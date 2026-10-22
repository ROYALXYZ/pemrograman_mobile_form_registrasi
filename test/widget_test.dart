import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:form_registrasi/main.dart';

void main() {
  testWidgets('Menampilkan seluruh field form registrasi', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Buat Akun Baru'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Nomor Telepon'), findsOneWidget);
    expect(find.text('Tanggal Lahir'), findsOneWidget);
    expect(find.text('Jenis Kelamin'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Konfirmasi Password'), findsOneWidget);
    expect(find.text('Saya setuju dengan Syarat & Ketentuan'), findsOneWidget);
  });

  testWidgets('Menampilkan pesan error saat form kosong disubmit', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final tombolDaftar = find.widgetWithText(ElevatedButton, 'Daftar');
    await tester.ensureVisible(tombolDaftar);
    await tester.pumpAndSettle();
    await tester.tap(tombolDaftar);
    await tester.pump();

    expect(find.text('Nama tidak boleh kosong'), findsOneWidget);
    expect(find.text('Email tidak boleh kosong'), findsOneWidget);
    expect(find.text('Nomor telepon tidak boleh kosong'), findsOneWidget);
    expect(find.text('Tanggal lahir tidak boleh kosong'), findsOneWidget);
    expect(find.text('Jenis kelamin harus dipilih'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong'), findsOneWidget);
    expect(find.text('Konfirmasi password tidak boleh kosong'), findsOneWidget);
    expect(
      find.text('Anda harus menyetujui Syarat & Ketentuan'),
      findsOneWidget,
    );
  });

  testWidgets('Menampilkan indikator kekuatan password', (tester) async {
    await tester.pumpWidget(const MyApp());

    final passwordField = find.byType(TextFormField).at(4);

    await tester.enterText(passwordField, 'Abcdefg1');
    await tester.pump();
    expect(find.text('Kekuatan password: Sedang'), findsOneWidget);

    await tester.enterText(passwordField, 'Abcdefg1!');
    await tester.pump();
    expect(find.text('Kekuatan password: Kuat'), findsOneWidget);

    await tester.enterText(passwordField, 'abc');
    await tester.pump();
    expect(find.text('Kekuatan password: Lemah'), findsOneWidget);
  });
}
