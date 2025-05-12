import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'todaentrega.contato@gmail.com',
      query: 'subject=Need Help&body=Describe your issue here...',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/+55 38992365600');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF5F8FA),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _sectionTitle("FAQs"),
            _faqItem("How do I track a package?",
                "Go to the tracking section, paste your tracking number, and hit 'Track'."),
            _faqItem("Why is my tracking info not updating?",
                "Some carriers update data with delay. Please try again later."),
            _faqItem("How do I upgrade my membership?",
                "Visit the Membership section in the app to view and purchase plans."),
            const SizedBox(height: 24),
            _sectionTitle("Contact Us"),
            _contactCard(
              icon: Icons.email,
              title: "Email Support",
              subtitle: "support@entregaapp.com",
              onTap: _launchEmail,
            ),
            const SizedBox(height: 12),
            _contactCard(
              icon: Icons.message,
              title: "WhatsApp Chat",
              subtitle: "+1 234 567 890",
              onTap: _launchWhatsApp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(answer, style: const TextStyle(color: Colors.black54)),
          )
        ],
      ),
    );
  }

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
