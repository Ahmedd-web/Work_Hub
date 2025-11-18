import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_job_detail_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerJobsPage extends StatefulWidget {
  const EmployerJobsPage({super.key});

  @override
  State<EmployerJobsPage> createState() => _EmployerJobsPageState();
}

class _EmployerJobsPageState extends State<EmployerJobsPage> {
  final int _currentNavIndex = 1;
  int _statusIndex = 0;
  String _searchQuery = '';

  final List<String> _tabs = ['فعالة', 'مؤرشفة', 'محذوفة'];
  final List<String> _statusFilters = ['active', 'archived', 'deleted'];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showBackButton: false,
            showMenuButton: true,
            showNotificationButton: true,
            showSearchBar: false,
            overlayChild: _JobsSearchField(
              initialValue: _searchQuery,
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            overlayHeight: 70,
            height: 160,
          ),
          Expanded(
            child:
                user == null
                    ? const Center(
                      child: Text('يرجى تسجيل الدخول لعرض الوظائف'),
                    )
                    : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('job_posts')
                              .where('owner_uid', isEqualTo: user.uid)
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'تعذر تحميل الوظائف: ${snapshot.error}',
                            ),
                          );
                        }
                        final docs = snapshot.data?.docs ?? [];
                        final statusKey = _statusFilters[_statusIndex];
                        final query = _searchQuery.trim().toLowerCase();
                        final jobs =
                            docs.where((doc) {
                              final data = doc.data();
                              final status =
                                  (data['status'] as String?) ?? 'active';
                              final title =
                                  (data['arabic_title'] as String?) ?? '';
                              final matchesStatus = status == statusKey;
                              final matchesSearch =
                                  query.isEmpty
                                      ? true
                                      : title.toLowerCase().contains(query);
                              return matchesStatus && matchesSearch;
                            }).toList();

                        return ListView(
                          padding: const EdgeInsets.fromLTRB(20, 56, 20, 120),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                                  _tabs.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final text = entry.value;
                                    final active = _statusIndex == index;
                                    return Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: index == 0 ? 0 : 8,
                                          right:
                                              index == _tabs.length - 1 ? 0 : 8,
                                        ),
                                        child: GestureDetector(
                                          onTap:
                                              () => setState(
                                                () => _statusIndex = index,
                                              ),
                                          child: Container(
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color:
                                                  active
                                                      ? AppColors.purple
                                                      : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color:
                                                    active
                                                        ? Colors.transparent
                                                        : AppColors.purple,
                                              ),
                                              boxShadow:
                                                  active
                                                      ? [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withValues(
                                                                alpha: 0.08,
                                                              ),
                                                          blurRadius: 6,
                                                          offset: const Offset(
                                                            0,
                                                            3,
                                                          ),
                                                        ),
                                                      ]
                                                      : null,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                color:
                                                    active
                                                        ? Colors.white
                                                        : AppColors.purple,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                            const SizedBox(height: 24),
                            if (jobs.isEmpty)
                              const Center(
                                child: Text(
                                  'لا توجد وظائف',
                                  style: TextStyle(
                                    color: AppColors.bannerGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            else
                              ...jobs.map(
                                (doc) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _JobCard(
                                    data: doc.data(),
                                    jobId: doc.id,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: EmployerBottomNav(
        currentIndex: _currentNavIndex,
        onChanged: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerDashboardPage()),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerResumesPage()),
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerAccountPage()),
            );
          }
        },
      ),
    );
  }
}

class _JobsSearchField extends StatelessWidget {
  const _JobsSearchField({required this.onChanged, required this.initialValue});

  final ValueChanged<String> onChanged;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9;
    return Center(
      child: Material(
        color: Colors.white,
        elevation: 4,
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: width,
          height: 54,
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: initialValue),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ابحث في الوظائف',
                  ),
                  onChanged: onChanged,
                ),
              ),
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.data, required this.jobId});

  final Map<String, dynamic> data;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    final status = (data['status'] as String?) ?? 'active';
    final arabicTitle = (data['arabic_title'] as String?) ?? 'وظيفة';
    final experienceYears = (data['experience_years'] as String?) ?? '-';
    final educationLevel = (data['education_level'] as String?) ?? '-';
    final country = (data['country'] as String?) ?? '-';

    Color statusColor;
    String statusText;
    switch (status) {
      case 'archived':
        statusColor = Colors.orange;
        statusText = 'مؤرشفة';
        break;
      case 'deleted':
        statusColor = Colors.red;
        statusText = 'محذوفة';
        break;
      default:
        statusColor = AppColors.bannerGreen;
        statusText = 'فعالة';
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EmployerJobDetailPage(jobData: data, jobId: jobId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.place, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(country, style: const TextStyle(color: Colors.grey)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arabicTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.purple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('سنوات الخبرة: $experienceYears'),
                      Text('مستوى التعليم: $educationLevel'),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F5EA),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(AppAssets.headerLogo, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.bannerGreen.withValues(
                    alpha: 0.15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: const Text(
                  'فعالة',
                  style: TextStyle(
                    color: AppColors.bannerGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
