import 'package:flutter/material.dart';
import 'package:test_drive/helpers/validation_manager.dart';
import 'package:test_drive/models/note.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/services/note_service.dart';
import 'package:test_drive/widgets/bottom_menu.dart';
import 'package:test_drive/widgets/topbar.dart';
import 'package:get_it/get_it.dart';
import 'package:test_drive/widgets/warning_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class Notes extends StatefulWidget {
  const Notes({super.key});
  static const routeName = '/notes';

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  ValidationManager validate = getIt.get<ValidationManager>();
  late NoteService service  = getIt.get<NoteService>();
  List _notes = [];
  String selectedType = 'white';
  final TextEditingController _controller = TextEditingController();

  Future<List> loadNotes() async {
    return _notes = await service.load();
  }

  void _addItem() async {
    var note = Note(
      id: null, 
      description: _controller.text,
      type: selectedType, 
    );
    if(validate.notesValidation(note)){
      service.saveNote(_controller.text, selectedType);
      _notes = await service.load();
      _controller.clear();
      setState(() {
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          backgroundColor: Palette.danger,
          content: Text(AppLocalizations.of(context)!.specificareDescrizione),
        ),
      );
    }
  }

  void _delete(id) async {
    service.delete(id);
    _notes = await service.load();
    _controller.clear();
    setState(() {
    });
  }

  Color colorFromType(type) {
    switch (type) {
      case 'default':
        return Palette.successColor;
      case 'info':
        return Palette.info;
      case 'warning':
        return Palette.warning;
      case 'danger':
        return Palette.danger;
      default: return Palette.white;
    }
  }

  @override
  void initState() {
    loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(title:AppLocalizations.of(context)!.note, father:true),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text input area
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.descrizioneNota,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(8),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                GestureDetector( 
                  onTap:(){
                    selectedType = 'default';
                    setState(() {}); 
                  },
                  child: CircleAvatar(
                    radius: 22, backgroundColor: selectedType=='default'? Palette.neutral: Palette.white , 
                    child: CircleAvatar(backgroundColor: Palette.successColor, radius: 20,child: (selectedType=='default')
                      ?const Icon(Icons.task_alt_outlined, size:30) 
                      : Container(), 
                    ))),
                const SizedBox(width: 8),
                GestureDetector( 
                  onTap:(){
                    selectedType = 'info';
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 22, backgroundColor: selectedType=='info'? Palette.neutral: Palette.white , 
                    child: CircleAvatar(backgroundColor: Palette.info, radius: 20,child: (selectedType=='info')
                      ?const Icon(Icons.task_alt_outlined, size:30) 
                      :Container(), 
                    ))),
                const SizedBox(width: 8),   
                GestureDetector( 
                  onTap:(){
                    selectedType = 'warning';
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 22, backgroundColor: selectedType=='warning'? Palette.neutral: Palette.white , 
                    child: CircleAvatar(backgroundColor: Palette.accent, radius: 20,child: (selectedType=='warning')
                      ?const Icon(Icons.task_alt_outlined, size:30) 
                      : Container(), 
                    ))),
                const SizedBox(width: 8),
                GestureDetector( 
                  onTap:(){
                    selectedType = 'danger';
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 22, backgroundColor: selectedType=='danger'? Palette.neutral: Palette.white , 
                    child: CircleAvatar(backgroundColor: Palette.danger, radius: 20,child: (selectedType=='danger')
                      ?const Icon(Icons.task_alt_outlined, size:30) 
                      : Container(), 
                    ))),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _addItem();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    backgroundColor: Palette.primary, 
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))// Background color
                  ),
                  child: Text(AppLocalizations.of(context)!.aggiungi, style: const TextStyle(color: Colors.white),),
                ),
              ],
            ),
            const Divider(),
            // Grid of colored note cards
            Expanded(
              child: FutureBuilder(
                future: loadNotes(), 
                builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : (_notes.isNotEmpty)
                    ?GridView.builder(
                          itemCount: _notes.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onLongPress: ()=>_delete(_notes[index].id),
                              child: Card(
                                color: colorFromType(_notes[index].type),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 4,
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _notes[index].description,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        :WarningMessage(message: AppLocalizations.of(context)!.nonCiSonoNote)
                    )

            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

}
