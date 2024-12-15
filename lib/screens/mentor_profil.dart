import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'mentor_screen.dart';

// Mentör Profil Ekranı
class MentorProfileScreen extends StatelessWidget {
  final String mentorId;

  const MentorProfileScreen({required this.mentorId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilim'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('mentors')
            .doc(mentorId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Mentör bilgisi bulunamadı.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final profileImageUrl = data['profileImageUrl'] ?? '';
          final ad = data['ad'] ?? '';
          final soyad = data['soyad'] ?? '';
          final telefon = data['telefon'] ?? '';
          final eposta = data['eposta'] ?? '';
          final adres = data['adres'] ?? '';
          final dogumTarihi = data['dogum_tarihi'] ?? '';
          final uzmanlikAlani = data['uzmanlik_alani'] ?? '';
          final deneyim = data['deneyim'] ?? '';
          final egitim = data['egitim'] ?? '';

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profil Fotoğrafı
                GestureDetector(
                  onTap: () {
                    // Profil fotoğrafını düzenlemek için yeni sayfaya yönlendir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MentorFormPage(mentorId: mentorId),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : null,
                    backgroundColor: Colors.blueAccent.withOpacity(0.1),
                    child: profileImageUrl.isEmpty
                        ? Icon(Icons.person, size: 60, color: Colors.grey[700])
                        : null,
                  ),
                ),
                SizedBox(height: 16),

                // Ad ve Soyad
                Text(
                  '$ad $soyad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 16),

                // Bilgilerim Kartı
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.phone, "Telefon", telefon),
                        _buildInfoRow(Icons.email, "E-posta", eposta),
                        _buildInfoRow(Icons.home, "Adres", adres),
                        _buildInfoRow(Icons.calendar_today, "Doğum Tarihi", dogumTarihi),
                        _buildInfoRow(Icons.business, "Uzmanlık Alanı", uzmanlikAlani),
                        _buildInfoRow(Icons.work, "Deneyim", deneyim),
                        _buildInfoRow(Icons.school, "Eğitim", egitim),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Öğrencilerim Kartı
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Eşleştiğim Öğrenciler",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildInfoRow(Icons.person, "Öğrenci Adı", "Mehmet Çelik"),
                        _buildInfoRow(Icons.calendar_today, "Randevu Tarihi", "21 Aralık 2024"),
                        _buildInfoRow(Icons.access_time, "Randevu Saati", "15:00"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/editProfile', // Düzenleme formu sayfasına gider
                      arguments: mentorId,
                    );
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Bilgilerimi Düzenle'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Yardımcı Metot: Bilgi Satırını Oluşturur
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


