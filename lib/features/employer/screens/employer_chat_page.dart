import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmployerChatPage extends StatefulWidget {
  const EmployerChatPage({
    super.key,
    required this.applicantId,
    required this.applicantName,
    required this.jobId,
    required this.jobTitle,
  });

  final String applicantId;
  final String applicantName;
  final String jobId;
  final String jobTitle;

  @override
  State<EmployerChatPage> createState() => _EmployerChatPageState();
}

class _EmployerChatPageState extends State<EmployerChatPage> {
  final TextEditingController controller = TextEditingController();
  late final String employerId;

  String get conversationId => '${widget.jobId}_${widget.applicantId}';

  @override
  void initState() {
    super.initState();
    employerId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    controller.clear();
    final ref = FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId);
    final msgRef = ref.collection('messages').doc();
    await ref.set({
      'job_id': widget.jobId,
      'job_title': widget.jobTitle,
      'employer_id': employerId,
      'applicant_id': widget.applicantId,
      'applicant_name': widget.applicantName,
      'last_message': text,
      'last_sender': employerId,
      'updated_at': FieldValue.serverTimestamp(),
      'unread_for_applicant': true,
      'unread_for_employer': false,
    }, SetOptions(merge: true));
    await msgRef.set({
      'text': text,
      'sender_id': employerId,
      'sender_role': 'employer',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.applicantName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance
                      .collection('conversations')
                      .doc(conversationId)
                      .collection('messages')
                      .orderBy('created_at', descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(child: Text('ابدأ المحادثة مع المتقدم'));
                }
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data();
                    final fromMe = data['sender_id'] == employerId;
                    return Align(
                      alignment:
                          fromMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              fromMe
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                    context,
                                  ).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          data['text'] ?? '',
                          style: TextStyle(
                            color:
                                fromMe
                                    ? Colors.white
                                    : Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
