import 'package:flutter/material.dart';
import 'package:test_drive/providers/travels_provider.dart';
import 'package:test_drive/widgets/cover_travel.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/widgets/select_action_travel.dart';

GetIt getIt = GetIt.instance;

class DestinationsCardView extends StatefulWidget {
  final List<dynamic> travels;
  final Function onUpdate;
  const DestinationsCardView({required this.travels, required this.onUpdate, super.key});

  @override
  State<DestinationsCardView> createState() => _DestinationsCardViewState();
}

class _DestinationsCardViewState extends State<DestinationsCardView> {
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
    return GridView.builder(
      itemCount: widget.travels.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: (){
            provider.selectTravel(widget.travels[index]);
            showBottomDialog(context);
          },
          child: Card(                        
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            //Text(widget.travels[index].name),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                              widget.travels[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),                          
                          ],
                      ))
                    )
                  ],)
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
