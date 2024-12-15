import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MentorFormPage extends StatefulWidget {
  late final String mentorId; // Mentor ID'si alınıyor

  MentorFormPage({required this.mentorId});  // Mentor ID'sini alıyoruz
  @override
  _MentorFormPageState createState() => _MentorFormPageState();
}

class _MentorFormPageState extends State<MentorFormPage> {
  // TextEditingController'lar
  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController dogumTarihiController = TextEditingController();
  final TextEditingController uzmanlikAlaniController = TextEditingController();

  // Seçimler için değişkenler
  String? selectedBolum;
  String? selectedSektor;
  String? selectedUniversite;
  String? selectedDeneyim;

  final firestoreRef = FirebaseFirestore.instance; // Firestore referansı

  @override
  void initState() {
    super.initState();
    _loadMentorData(); // Mentör verilerini yükle
  }

  // Mevcut mentör verilerini Firestore'dan çek
  void _loadMentorData() async {
    try {
      final doc = await firestoreRef.collection('mentors').doc(widget.mentorId).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          adController.text = data['ad'] ?? '';
          soyadController.text = data['soyad'] ?? '';
          emailController.text = data['email'] ?? '';
          sifreController.text = data['sifre'] ?? '';
          telefonController.text = data['telefon'] ?? '';
          adresController.text = data['adres'] ?? '';
          dogumTarihiController.text = data['dogum_tarihi'] ?? '';
          uzmanlikAlaniController.text = data['uzmanlik_alani'] ?? '';
          selectedBolum = data['bolum'] ?? null;
          selectedSektor = data['sektor'] ?? null;
          selectedUniversite = data['universite'] ?? null;
          selectedDeneyim = data['deneyim'] ?? null;
        });
      }
    } catch (e) {
      print('Mentör verileri yüklenirken hata oluştu: $e');
    }
  }

  void saveData() {
    if (adController.text.isNotEmpty && soyadController.text.isNotEmpty) {
      firestoreRef.collection("mentors").doc(widget.mentorId).update({
        'ad': adController.text,
        'soyad': soyadController.text,
        'email': emailController.text,
        'sifre': sifreController.text,
        'telefon': telefonController.text,
        'adres': adresController.text,
        'dogum_tarihi': dogumTarihiController.text,
        'uzmanlik_alani': uzmanlikAlaniController.text,
        'bolum': selectedBolum ?? 'Belirtilmedi',
        'sektor': selectedSektor ?? 'Belirtilmedi',
        'universite': selectedUniversite ?? 'Belirtilmedi',
        'deneyim': selectedDeneyim ?? 'Belirtilmedi',
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veri başarıyla güncellendi.')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ad ve Soyad alanları zorunludur!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentör Bilgi Sistemi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mentör Bilgilerini Giriniz', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            _buildTextField(adController, 'Ad'),
            _buildTextField(soyadController, 'Soyad'),
            _buildTextField(emailController, 'E-posta', TextInputType.emailAddress),
            _buildTextField(sifreController, 'Şifre'),
            _buildTextField(telefonController, 'Telefon', TextInputType.phone),
            _buildTextField(adresController, 'Adres'),
            _buildTextField(dogumTarihiController, 'Doğum Tarihi (DD/AA/YYYY)', TextInputType.datetime),
            _buildTextField(uzmanlikAlaniController, 'Uzmanlık Alanı'),
            _buildDropdown(selectedBolum, 'Bölüm', ['Bolum A', 'Bolum B', 'Bolum C']),
            _buildDropdown(selectedSektor, 'Sektör', ['Sektor 1', 'Sektor 2', 'Sektor 3']),
            _buildDropdown(selectedUniversite, 'Üniversite', ['Universite A', 'Universite B', 'Universite C']),
            _buildDropdown(selectedDeneyim, 'Deneyim Seviyesi', ['Yeni Baslayan', 'Orta Duzey', 'Uzman']),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: saveData,
                child: Text('Güncelle'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, [TextInputType keyboardType = TextInputType.text, bool obscureText = false]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }

  Widget _buildDropdown(String? selectedValue, String label, List<String> items) {
    // Eğer değer 'Belirtilmedi' olarak gelmişse, listede ekli değilse ekle.
    if (!items.contains('Belirtilmedi')) {
      items.insert(0, 'Belirtilmedi'); // Listenin başına ekler
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        value: selectedValue ?? 'Belirtilmedi',
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (label == 'Bölüm') selectedBolum = value;
            if (label == 'Sektör') selectedSektor = value;
            if (label == 'Üniversite') selectedUniversite = value;
            if (label == 'Deneyim Seviyesi') selectedDeneyim = value;
          });
        },
      ),
    );
  }
}
