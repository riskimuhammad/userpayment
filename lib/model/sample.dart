// **** **** **** **** START OF DOCUMENT **** **** **** ****
//
// This document is ended when you encounter “END OF DOCUMENT”.
//
// X/Link Software
// Flutter Developer Remote Coding Assignment
//
// By reading this document, you are agreed to securely keep this document, and will not distribute it to others.
// If you do not agree, please stop reading and delete this document.

// 1.	General information:
//    a.	Code must be completed within 1 week since receiving remote code assignment.
//    b.	When completed, compress final folder that contain Project, Source Code and GIT History using ZIP or RAR.
//    c.	Email compressed folder to ahsaputro@infolink.co.id.
// 2.	Technical Information:
//    a.	Assignment must be developed using flutter/dart.
//    b.	Assignment must be coded using Android Studio, minimum version Electric Eel 2022.1.1.
//    c.	Development must be committed into GIT source control for every new feature added or every bug fixed for historical review.
//    d.	Code must be compileable without any error.
//    e.	Code must be runnable in android according to specification provided in Assignment One and Assignment Two.

// Data source:
//   i.	Sample data are provided in dart code in file “sample.dart” (this file).
//  ii.	Use the data provided in “sample.dart” to populate selection inside combobox, and draw tree in textbox.
// iii.	You must use “sample.dart”.
//  iv.	You may not ignore “sample.dart”.
//   v.	You may not alter any code inside “sample.dart”.
//  vi.	The populated combobox and generated tree in textbox must be sourced from “sample.dart”.

class Account {
  const Account(
    this.parentAccountNo,
    this.accountNo,
    this.balance,
  );

  final String parentAccountNo;
  final String accountNo;
  final int balance;
}

class SampleAccount {
  SampleAccount({
    required this.sampleName,
    required this.rootAccountNo,
    required this.accounts,
  });

  final String sampleName;
  final String rootAccountNo;
  List<Account> accounts;
}

class Sample {
  static List<SampleAccount> sampleAccounts = [
    SampleAccount(
      sampleName: "Accounts Sample 1",
      rootAccountNo: "0000",
      accounts: [
        const Account("", "0000", 0),
        const Account("0000", "0001", 1),
        const Account("0000", "0002", 2),
      ],
    ),
    SampleAccount(
      sampleName: "Accounts Sample 2",
      rootAccountNo: "0000",
      accounts: [
        const Account("", "0000", 0),
        const Account("0000", "0001", 0),
        const Account("0001", "0002", 0),
        const Account("0002", "0003", 0),
        const Account("0003", "0004", 4),
      ],
    ),
    SampleAccount(
      sampleName: "Accounts Sample 3",
      rootAccountNo: "0000",
      accounts: [
        const Account("", "0000", 0),
        const Account("0000", "0001", 0),
        const Account("0001", "0002", 20),
        const Account("0001", "0003", 30),
        const Account("0000", "0004", 0),
        const Account("0004", "0005", 50),
        const Account("0004", "0006", 0),
        const Account("0006", "0007", 0),
        const Account("0007", "0008", 80),
        const Account("0007", "0009", 90),
      ],
    ),
    SampleAccount(
      sampleName: "Accounts Sample 4",
      rootAccountNo: "000000",
      accounts: [
        const Account("", "000000", 0),
        const Account("000008", "000083", 83000),
        const Account("000008", "000082", 82000),
        const Account("000000", "000001", 0),
        const Account("000001", "000011", 0),
        const Account("000011", "000111", 111000),
        const Account("000011", "000112", 0),
        const Account("000112", "001121", 1121000),
        const Account("000112", "001122", 1122000),
        const Account("000112", "000004", 4000),
        const Account("000011", "000113", 113000),
        const Account("000092", "000921", 921000),
        const Account("000009", "000091", 91000),
        const Account("000009", "000092", 0),
        const Account("000002", "000009", 0),
        const Account("000001", "000012", 12000),
        const Account("000001", "000005", 5),
        const Account("000000", "000002", 0),
        const Account("000002", "000021", 21000),
        const Account("000002", "000022", 22000),
        const Account("000002", "000006", 0),
        const Account("000006", "000061", 0),
        const Account("000061", "000611", 0),
        const Account("000611", "006111", 6111000),
        const Account("000002", "000007", 7000),
        const Account("000009", "000008", 8000),
        const Account("000008", "000081", 81000),
      ],
    ),
    SampleAccount(
      sampleName: "Accounts Sample 5",
      rootAccountNo: "0",
      accounts: [
        const Account("", "0", 0),
        const Account("0", "1", 0),
        const Account("1", "11", 0),
        const Account("11", "111", 0),
        const Account("111", "1111", 1111),
        const Account("111", "1112", 1112),
        const Account("11", "112", 0),
        const Account("112", "1121", 1121),
        const Account("112", "1122", 1122),
        const Account("1", "12", 0),
        const Account("12", "121", 121),
        const Account("12", "122", 122),
        const Account("0", "2", 0),
        const Account("2", "21", 0),
        const Account("21", "211", 211),
        const Account("21", "212", 212),
        const Account("2", "22", 0),
        const Account("22", "221", 221),
        const Account("22", "222", 222),
      ],
    ),
  ];
}

//GOOD LUCK, AND HAPPY CODING!!!! 

// Copyright P.T. Metalogix Infolink Persada, February 2023.
// **** **** **** **** END OF DOCUMENT **** **** **** ****
