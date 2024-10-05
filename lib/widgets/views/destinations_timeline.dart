import 'package:flutter/material.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/providers/travels_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/widgets/cover_travel.dart';
import 'package:test_drive/widgets/select_action_travel.dart';

GetIt getIt = GetIt.instance;

class DestinationsTimeline extends StatefulWidget {
  final List<dynamic> travels;
  final Function onUpdate;
  const DestinationsTimeline({required this.travels, required this.onUpdate, super.key});
  static const routeName = '/destinations-timeline';

  @override
  State<DestinationsTimeline> createState() => _DestinationsTimelineState();
}

class _DestinationsTimelineState extends State<DestinationsTimeline> {
  
  void showBottomDialog(context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SelectActionTravel(
          onSelect: (){
            Navigator.pop(context);
            setState(() {
                
            });
            widget.onUpdate();
          },
        );
      },
    );
  }
    
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelsProvider>(context, listen: false);

    return ListView.builder(            
      itemCount: widget.travels.length, // Change this count based on your data
      itemBuilder: (context, index) {
        // widget.travels.sort((a, b) {
        //   DateTime dateA = DateTime.parse(a.dateEnd);
        //   DateTime dateB = DateTime.parse(b.dateEnd);
        //   return dateB.compareTo(dateA); 
        // });
        return Row(
          children: [
            Column(
              children: [
                const Icon(Icons.fiber_manual_record, color: Colors.red, size: 14,),
                Container(
                  width: 1,
                  height: 160, // Adjust this height based on your design
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap:(){
                  provider.selectTravel(widget.travels[index]);
                  showBottomDialog(context);
                },
                child: Card.outlined(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child:ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 150,
                width: 100,
                child: Stack(children: [
                  Positioned.fill(
                    child: (widget.travels[index].image != null)
                    ?CoverTravel(
                      detail: true,
                      cover: widget.travels[index].image,
                      travel: widget.travels[index].name,
                      onSaveFunction: null,
                    )
                    :Icon(
                      Icons.photo,
                      size: 100.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  Positioned( 
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.travels[index].dateStart} - ${widget.travels[index].dateEnd}',
                            style: const TextStyle(fontSize: 12, color: Palette.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.travels[index].name, 
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Palette.white),
                          ),
                          ( widget.travels[index].notes.length > 0)
                            ?const SizedBox(height: 4): Container(),
                          (widget.travels[index].notes.length > 0)
                            ?Text(
                              widget.travels[index].notes, 
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16, color: Palette.white),
                            ): Container(),                         
                        ],
                    ))
                  )
                ],),),),),
              ),
            ),
          ],
        );
      },
    );
  }
}
