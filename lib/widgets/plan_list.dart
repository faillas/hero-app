import 'package:flutter/material.dart';
import 'package:test_drive/helpers/date_manager.dart';
import 'package:test_drive/helpers/icon_manager.dart';
import 'package:test_drive/models/plan.dart';
import 'package:get_it/get_it.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/widgets/warning_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class PlanList extends StatefulWidget {
  final List<Plan> items;
  final String trailingKey;
  final bool? isEdit;
  final Function onDelete;
  const PlanList({required this.items, required this.trailingKey, this.isEdit, required this.onDelete, super.key});

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  DateManager dateManager = getIt.get<DateManager>();
  IconManager iconManager = getIt.get<IconManager>();

  @override
  void initState() {
    super.initState();
    // DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    // widget.items.sort((a, b) => DateTime.parse('${a.date} ${a.hourStart}').compareTo(DateTime.parse('${b.date} ${b.hourStart}')));
  }

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
          leading: CircleAvatar(radius: 16, backgroundColor: Palette.info.withOpacity(0.25), child: iconManager.getIconFromLabel(widget.items[index].category),),
          subtitle:Text(
            widget.items[index].description, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
          title: Text(
            '${dateManager.formatStringFromDate(widget.items[index].date)} - ${widget.items[index].hourStart}',
            style: const TextStyle(fontSize: 12),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (widget.isEdit ==null)
              ?IconButton(
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
    :WarningMessage(message: AppLocalizations.of(context)!.nonCiSonoPianificazioniRegistrate);
  }
}
