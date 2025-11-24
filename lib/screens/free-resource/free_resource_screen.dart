import 'package:flutter/material.dart';
import '../../models/resource_model.dart';
import '../../services/resource_service.dart';
import './widgets/pdf_viewer_page.dart';

class FreeResourcesPage extends StatefulWidget {
  @override
  _FreeResourcesPageState createState() => _FreeResourcesPageState();
}

class _FreeResourcesPageState extends State<FreeResourcesPage> {
  bool loading = true;
  List<ResourceModel> list = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    List<ResourceModel> result = await ResourceService.getResources();

    setState(() {
      list = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Free Resources"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PdfViewerPage(pdfUrl: item.asset),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue,
                        width: index == 0 ? 3 : 0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      item.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
