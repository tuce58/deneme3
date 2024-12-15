import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfileScreen extends StatelessWidget {
  final String studentId;

  const StudentProfileScreen({required this.studentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilim'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Öğrenci bilgisi bulunamadı.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final profileImageUrl = data['profileImageUrl'] ?? '';
          final ad = data['ad'] ?? '';
          final soyad = data['soyad'] ?? '';
          final telefon = data['telefon'] ?? '';
          final eposta = data['eposta'] ?? '';
          final adres = data['adres'] ?? '';
          final dogumTarihi = data['dogum_tarihi'] ?? '';
          final tcKimlik = data['tc_kimlik'] ?? '';
          final sinif = data['sinif'] ?? '';
          final universite = data['universite'] ?? '';
          final bolum = data['bolum'] ?? '';

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profil Fotoğrafı
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : null,
                  backgroundColor: Colors.blueAccent.withOpacity(0.1),
                  child: profileImageUrl.isEmpty
                      ? Icon(Icons.person, size: 60, color: Colors.grey[700])
                      : null,
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
                        _buildInfoRow(Icons.perm_identity, "T.C. Kimlik No", tcKimlik),
                        _buildInfoRow(Icons.school, "Sınıf", sinif),
                        _buildInfoRow(Icons.account_balance, "Üniversite", universite),
                        _buildInfoRow(Icons.engineering, "Bölüm", bolum),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Eşleştiğim Mentör Kartı
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
                          "Eşleştiğim Mentör",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildInfoRow(Icons.person, "Mentör Adı", "Ahmet Yılmaz"),
                        _buildInfoRow(Icons.calendar_today, "Randevu Tarihi", "20 Aralık 2024"),
                        _buildInfoRow(Icons.access_time, "Randevu Saati", "14:00"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Düzenle Butonu
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/editProfile', // Düzenleme formu sayfasına gider
                      arguments: studentId,
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
