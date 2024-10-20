import 'package:flutter/material.dart';
import 'package:hero/models/budget.dart';
import 'package:hero/palette.dart';
import 'package:hero/widgets/warning_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BudgetList extends StatefulWidget {
  final List<Budget> items;
  final String trailingKey;
  final bool? isEdit;
  final Function onDelete;
  const BudgetList({required this.items, required this.trailingKey, this.isEdit,  required this.onDelete, super.key});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  @override
  Widget build(BuildContext context) {
    return (widget.items.isNotEmpty)
    ?ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return ListTile(
          title: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(
                  widget.items[index].name, 
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).hintColor),
                  overflow: TextOverflow.ellipsis,
                ),),
                Row(
                  children: [
                    SizedBox(width:80,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.items[index].estimate,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    )),
                    Container(height: 15, color: Theme.of(context).dividerColor, width: 0.5,),
                    SizedBox(width:80,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.end,
                        widget.items[index].value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [  
              (widget.isEdit ==null)
              ?IconButton(
                color: Palette.accent,
                icon: const Icon(Icons.close, color: Palette.danger,),
                onPressed: () {
                  setState(() {
                    widget.onDelete(item);
                    widget.items.remove(item);
                  });
                },
              )
              :Container()
            ],
          ),
        );
      },
    )
    :WarningMessage(message: AppLocalizations.of(context)!.nonCiSonoBudget);
  }
}
