
import 'package:flutter/material.dart';
import 'package:test_drive/helpers/validation_manager.dart';
import 'package:test_drive/models/wish_item.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/services/wishlist_service.dart';
import 'package:test_drive/widgets/bottom_menu.dart';
import 'package:test_drive/widgets/topbar.dart';
import 'package:get_it/get_it.dart';
import 'package:test_drive/widgets/warning_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class WishList extends StatefulWidget {
  const WishList({super.key});
  static const routeName = '/wishlist';

  @override
  State<WishList> createState() => _WishListState();

}

class _WishListState extends State<WishList> {
  ValidationManager validate = getIt.get<ValidationManager>();
  late WishlistService service  = getIt.get<WishlistService>();
  List _wishlist = [];
  final TextEditingController _controller = TextEditingController();

  Future<List> loadWishItems() async {
    return _wishlist = await service.load();
  }

  void _addItem() async {
    var item = WishItem(
      id: null, 
      description: _controller.text,
      checked: 0, 
    );
    if(validate.wishlistValidation(item)){
      service.save(_controller.text, 0);
      loadWishItems();
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

  void _toggleItem(id, value) async {
    service.update(id, value);
    loadWishItems();
    _controller.clear();
    setState(() {
    });
  }

  void _delete(id) async {
    service.delete(id);
    loadWishItems();
    _controller.clear();
    setState(() {
    });
  }

  @override
  void initState() {
    loadWishItems();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(title:AppLocalizations.of(context)!.wishlist, father:true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addItem,
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    backgroundColor: Palette.primary,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)) // Background color
                  ),
                  child: Text(AppLocalizations.of(context)!.aggiungi, style: const TextStyle(color: Colors.white),),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            Expanded(
              child: FutureBuilder(
                future: loadWishItems(), 
                builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : (_wishlist.isNotEmpty)
                    ?ListView.builder(
                      itemCount: _wishlist.length,
                      itemBuilder: (_, index) {
                        _wishlist.sort((a, b) => a.checked.compareTo(b.checked));
                        return Column(
                          children: [
                            ListTile( 
                              leading: IconButton(
                                icon: const Icon(Icons.remove, color: Palette.danger,),
                                onPressed: () => _delete(_wishlist[index].id),
                              ),
                              title: Text(
                                _wishlist[index].description,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: _wishlist[index].checked == 1 ? TextDecoration.lineThrough : TextDecoration.none,
                                ),
                              ),
                              trailing: Checkbox(
                                value: _wishlist[index].checked == 0 ? false :true,
                                onChanged: (bool? value) {
                                  if(value == true){
                                    _toggleItem(_wishlist[index].id, 1);
                                  }else{
                                    _toggleItem(_wishlist[index].id, 0);
                                  }
                                },
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    )
                    :WarningMessage(message: AppLocalizations.of(context)!.nonCiSonoVociInWishlist)                  
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
