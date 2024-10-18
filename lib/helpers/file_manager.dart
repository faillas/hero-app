import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cross_file/cross_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:hero/data/categories_data.dart';
import 'package:hero/models/budget.dart';
import 'package:hero/models/plan.dart';
import 'package:hero/models/travel.dart';
import 'package:intl/intl.dart';

class FileManager {

  String validateCategory(category){
    if(category == null || category == ''){
      return 'N.D.';
    }
    return category;
  }

  Future<void> generatePlan(Travel travel, List<Plan> plans) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '${travel.name}: pianificazione',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: null,
                columnWidths: {
                  0: const pw.FixedColumnWidth(30),
                  1: const pw.FixedColumnWidth(120),
                  2: const pw.FixedColumnWidth(50),
                  3: const pw.FlexColumnWidth(),
                },
                children: [
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.red600,
                      border: pw.Border(
                        bottom: pw.BorderSide(
                          color: PdfColors.blueGrey900,
                          width: .5,
                        ),
                      ),
                    ),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Data e ora', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color:PdfColors.white )),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Cat.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color:PdfColors.white )),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Descrizione', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color:PdfColors.white )),
                    ),],
                  ),
                  ...plans.map((plan) {               
                    return  pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.blueGrey900,
                            width: .5,
                          ),
                        ),
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Container(
                            width: 20,
                            height: 20,
                            alignment: pw.Alignment.center,
                            child:pw.SvgImage(
                              svg: '''
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M384 80c8.8 0 16 7.2 16 16l0 320c0 8.8-7.2 16-16 16L64 432c-8.8 0-16-7.2-16-16L48 96c0-8.8 7.2-16 16-16l320 0zM64 32C28.7 32 0 60.7 0 96L0 416c0 35.3 28.7 64 64 64l320 0c35.3 0 64-28.7 64-64l0-320c0-35.3-28.7-64-64-64L64 32z"/></svg>                              
                              '''
                            ) 
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('${DateFormat("dd/MM/yyyy").format(DateTime.parse(plan.date))} ${plan.hourStart}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child:  
                          pw.Container(
                            width: 20,
                            height: 20,
                            alignment: pw.Alignment.center,
                            child:pw.SvgImage(
                              svg: getSvg(plan.category)
                            ) 
                          )                            
                          // Use the image for the category           
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(plan.description),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Print or save the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<void> generateCostsList(Travel travel, List<Budget> budgets) async {
    final pdf = pw.Document();
    var TOTestimate = 0.0;
    var TOTreal = 0.0;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '${travel.name}: costi',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: null, 
                columnWidths: {
                  0: const pw.FlexColumnWidth(),
                  1: const pw.FixedColumnWidth(80),
                  2: const pw.FixedColumnWidth(80),
                },             
                children: [
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.red600,
                      border: pw.Border(
                        bottom: pw.BorderSide(
                          color: PdfColors.blueGrey900,
                          width: .5,
                        ),
                      ),
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Budget', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color:PdfColors.white)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Preventivo', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color:PdfColors.white)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Reale', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color:PdfColors.white)),
                      ),
                    ]
                  ),
                  ...budgets.map((budget) {
                    TOTreal = TOTreal+ double.parse(budget.value);
                    TOTestimate = TOTestimate+ double.parse(budget.estimate);
                    return pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.blueGrey900,
                            width: .5,
                          ),
                        ),
                      ),
                      children: [
                        pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(budget.name), // Sample data for Budget
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(budget.estimate), // Sample data for Reale
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(budget.value), // Sample data for Preventivo
                        ),
                      ],
                    );
                  }),  
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(
                          color: PdfColors.blueGrey900,
                          width: .5,
                        ),
                      ),
                    ),
                    children: [
                      pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('TOTALE'), // Sample data for Budget
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(TOTestimate.toString()), // Sample data for Preventivo
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(TOTreal.toString()), // Sample data for Reale
                      ),
                    ],
                  )                              
                ],
              ),
            ],
          );
        },
      ),
    );
    // Print or save the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }



  Future<Uint8List?> convertXFileToUint8List(XFile? xfile) async {
    if (xfile == null) return null;
    Uint8List fileBytes = await xfile.readAsBytes();
    return fileBytes;
  }

  Future<XFile> convertUint8ListToXFile(Uint8List uint8List, String filename) async {
    // Get the temporary directory of the app
    final tempDir = await getTemporaryDirectory();
    // Create a temporary file path
    final filePath = '${tempDir.path}/$filename';
    // Write the byte data to the file
    final file = File(filePath);
    await file.writeAsBytes(uint8List);
    // Create an XFile from the file path
    final xFile = XFile(filePath);
    return XFile(filePath);
    
  }

  void exportPDF(type, object) async {
    final pdf = pw.Document();
    final img = await rootBundle.load('assets/logo.png');
    final imageBytes = img.buffer.asUint8List();
    if(type=='budgets'){
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(imageBytes)),
          ); // Center
        })
      );
    }else if(type=='plans'){
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(imageBytes)),
          ); // Center
        })
      );
    }
  }

  String getSvg(String? label) {
    final category = categories.where((cat)=> cat.label == label).firstOrNull;
    if(category != null){
      return category.rawSvg;
    }
    return '''
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM216 336l24 0 0-64-24 0c-13.3 0-24-10.7-24-24s10.7-24 24-24l48 0c13.3 0 24 10.7 24 24l0 88 8 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-80 0c-13.3 0-24-10.7-24-24s10.7-24 24-24zm40-208a32 32 0 1 1 0 64 32 32 0 1 1 0-64z"/></svg>
    ''';
  }
}
