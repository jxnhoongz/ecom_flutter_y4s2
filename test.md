 1. What is Android?

Android គឺជាប្រព័ន្ធប្រតិបត្តិការ (Operating System) សម្រាប់ទូរស័ព្ទឆ្លាតវៃ និង Tablets ដែលបង្កើតដោយ Google។
វាផ្អែកលើ Linux Kernel ហើយអាចអភិវឌ្ឍកម្មវិធីដោយប្រើ Java, Kotlin ឬ Flutter។

2. What is JDK?

JDK (Java Development Kit) គឺជាកញ្ចប់ឧបករណ៍សម្រាប់អភិវឌ្ឍកម្មវិធី Java ដែលរួមមាន JRE, Compiler និង Tools ផ្សេងៗ។
វាជាអ្វីដែល developer ត្រូវតែដំឡើង ដើម្បីកូដ Java ឬ Android។

3. What is Firebase?

Firebase គឺជា Backend Platform របស់ Google ដែលផ្ដល់សេវាកម្ម Cloud ដូចជា Authentication, Firestore Database, Storage, Hosting, Push Notification និង Analytics។
វាអនុញ្ញាតឲ្យអ្នកអភិវឌ្ឍ App មិនចាំបាច់សង់ backend ដោយខ្លួនឯង។

4. What is Flutter SDK?

Flutter SDK គឺជា Framework របស់ Google សម្រាប់បង្កើត Mobile, Web, Desktop App ដោយប្រើភាសា Dart។
វាមាន UI Widgets ដែលអាចរត់បានលើ Android និង iOS ដោយ Codebase តែមួយ។

5. What are Row and Column in Flutter?

Row: ដាក់ widget តាមជួរដេក (horizontal layout)
Column: ដាក់ widget តាមជួរឈរ (vertical layout)

Row = ចំនុំ widget នៅខាងតមបាត
Column = ចំនុំ widget ទៅលើ–ក្រោម

6. What is GetX?

GetX គឺជា Flutter State Management + Routing + Dependency Injection Framework ដែលមានភាពលឿន ស្រាល និងងាយប្រើ។
វាជួយសម្រួលការគ្រប់គ្រង state, navigation, និងលេខាធិការថ្នាក់ (DI)។

7. What is MVVM?

MVVM (Model–View–ViewModel) គឺជា Architecture Pattern សម្រាប់បែងចែក UI និង Logic អោយច្បាស់។

Model: ទិន្នន័យ

View: UI

ViewModel: Logic ដែលភ្ជាប់ View និង Model

វាធ្វើអោយ App មានរចនាសម្ព័ន្ធត្រឹមត្រូវ និងងាយ maintenance។

8. What is Stateless and Stateful?

Stateless Widget:

មិនប្តូរ state

UI កើតឡើងតែម្ដង (ex: Text, Icon)

Stateful Widget:

មាន state ប្ដូរ

UI អាច Update ដោយ setState() (ex: Button click, form input)

9. Why do we use Flutter for mobile app development?

Codebase តែមួយ លើ iOS + Android

Performace លឿន (compiled to native)

UI Widgets ស្អាត

Hot Reload

Fast development

Support Web/Desktop

10. Comparison Provider vs GetX
Comparison  Provider  GetX
Complexity  ត្រូវ setup ច្រើន  សាមញ្ញងាយប្រើ
Boilerplate  ច្រើន  តិច
Performance  ល្អ  ល្អណាស់
State Management  Basic  Reactive
Navigation  មិនមាន builtin  មាន Navigation System
Learning Curve  កម្រិតមធ្យម  សាមញ្ញ និងលឿន
11. What is HTTP and HTTPS?

HTTP: HyperText Transfer Protocol (មិនមានសុវត្ថិភាព)
HTTPS: HTTP + SSL/TLS Encryption (មានសុវត្ថិភាព)

HTTPS ធ្វើ encryption ទិន្នន័យ ដើម្បីការពារ password, payment, APIs។

12. What is Local Storage?

Local Storage គឺជាកន្លែងផ្ទុកទិន្នន័យនៅលើទូរស័ព្ទអ្នកប្រើ ដូចជា SharedPreferences, Hive, SQLite។
ប្រើសម្រាប់ token, settings, caching។

13. What is Scaffold?

Scaffold គឺជា Layout Structure នៅ Flutter ដែលផ្ដល់ AppBar, Body, Drawer, FloatingActionButton, BottomNavigationBar។
ជា UI skeleton សម្រាប់ទំព័រ Flutter។

14. Code ListView with dynamic data (Flutter)
List<String> items = ["Apple", "Banana", "Mango", "Orange"];

ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index]),
    );
  },
);

15. Code POST request to server API (Flutter + http)
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendData() async {
  final url = Uri.parse("https://example.com/api/login");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "username": "rady",
      "password": "123456"
    }),
  );

  if (response.statusCode == 200) {
    print("Success: ${response.body}");
  } else {
    print("Error: ${response.statusCode}");
  }
}