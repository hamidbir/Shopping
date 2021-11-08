import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/admin_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/utils/constants.dart';

class AdminPanel extends StatelessWidget {
  AdminPanel({Key? key}) : super(key: key);
  // TextEditingController taskCatConteroller = TextEditingController(
  //   text: 'انتخاب دسته بندی',
  // );
  // TextEditingController taskTitleConteroller = TextEditingController();
  // TextEditingController taskDescriptionConteroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AdminController adminController = Get.put(AdminController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.background,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: ColorConstants.background,
        body: Obx(() {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Card(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: adminController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                        onPressed: () {
                                          adminController.uploadToStorage(
                                              'eMlgqmMoq9Zi2mMc9Q4jWrsBSl72');
                                        },
                                        child: const Text('آپلود')),
                              ),
                              ListView.builder(
                                  itemCount: adminController.imageUrl.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          // child: Image.memory(base64Decode(
                                          //     adminController
                                          //         .imageUrl[index]))
                                          //         )
                                          child: Image.network(
                                              adminController.imageUrl[index],
                                              fit: BoxFit.fill)),
                                    );
                                  })
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'همه فرم را پر کنید ',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //
                                    _textTile('دسته بندی'),
                                    _textFormField(
                                        valueKey: 'TaskCategory',
                                        enabled: false,
                                        controller:
                                            adminController.shoeCatConteroller,
                                        onClick: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  _showCategoryList(
                                                      context,
                                                      size,
                                                      Constants
                                                          .taskCategoryList));
                                        },
                                        maxLength: 100),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 30,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: adminController
                                                  .category.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Chip(
                                                      onDeleted: () {
                                                        adminController
                                                            .removeCategory(
                                                                index);
                                                      },
                                                      label: Text(
                                                          adminController
                                                                  .category[
                                                              index])),
                                                );
                                              })),
                                    ),
                                    _textTile('نام کفش '),
                                    _textFormField(
                                        valueKey: 'TaskTitle',
                                        enabled: true,
                                        controller:
                                            adminController.shoeNameConteroller,
                                        onClick: () {},
                                        maxLength: 100),
                                    _textTile('قیمت'),
                                    _textFormField(
                                        valueKey: 'TaskTitle',
                                        enabled: true,
                                        controller: adminController
                                            .shoePriceConteroller,
                                        onClick: () {},
                                        maxLength: 100),
                                    _textTile('اندازه'),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: _textFormField(
                                              valueKey: 'Task',
                                              enabled: true,
                                              controller: adminController
                                                  .shoeSizeConteroller,
                                              onClick: () {},
                                              maxLength: 100),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              adminController.addSize();
                                            },
                                            child: const Text('افزودن')),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 30,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  adminController.sizes.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Chip(
                                                      onDeleted: () {
                                                        adminController
                                                            .removeSize(index);
                                                      },
                                                      label: Text(
                                                          adminController
                                                              .sizes[index])),
                                                );
                                              })),
                                    ),
                                    _textTile('رنگ'),
                                    _textFormField(
                                        valueKey: 'TaskTitle',
                                        enabled: false,
                                        controller: adminController
                                            .shoeColorConteroller,
                                        onClick: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  _showCategoryList(
                                                      context,
                                                      size,
                                                      Constants.shoeColorList));
                                          //adminController.addColor();
                                        },
                                        maxLength: 100),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 30,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  adminController.colors.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Chip(
                                                      onDeleted: () {
                                                        adminController
                                                            .removeColor(index);
                                                      },
                                                      label: Text(
                                                          adminController
                                                              .colors[index])),
                                                );
                                              })),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            adminController.isLoading.value
                                ? const CircularProgressIndicator()
                                : Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            await adminController.upload(
                                                    'eMlgqmMoq9Zi2mMc9Q4jWrsBSl72')
                                                ? Get.snackbar('ذخیره شد',
                                                    'با موفیقت ذخیره شد',
                                                    backgroundColor:
                                                        Colors.greenAccent)
                                                : Get.snackbar(
                                                    'خطا',
                                                    adminController
                                                        .errorText.value,
                                                    backgroundColor:
                                                        Colors.redAccent);
                                          },
                                          //     onPressed: _uploadTaskButton,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Text('ذخیره'),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.upload_file)
                                            ],
                                          )),
                                    ),
                                  ),
                            //Container()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget _showCategoryList(BuildContext context, Size size, List<String> list) {
    final AdminController admin = Get.find();
    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('انصراف',
                  style: TextStyle(color: Colors.blueAccent))),
        ],
        title: const Text('انتخاب دسته بندی',
            style: TextStyle(color: Colors.pink, fontSize: 22)),
        content: SizedBox(
          width: size.width * 0.9,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length, // Constants.taskCategoryList.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    if (list == Constants.taskCategoryList) {
                      admin.addCategory(index);
                    } else {
                      admin.addColor(index);
                    }
                    Navigator.of(context).pop();
                  },
                  child: ListTile(
                    leading: const Icon(Icons.access_alarm, color: Colors.pink),
                    title: Text(
                      list[index],
                      style: const TextStyle(color: Colors.indigoAccent),
                    ),
                  ),
                );
              }),
        ));
  }

  Widget _textFormField(
      {required String valueKey,
      required bool enabled,
      required TextEditingController controller,
      required Function() onClick,
      required int maxLength}) {
    return InkWell(
      onTap: onClick,
      child: TextFormField(
        onFieldSubmitted: (text) {},
        controller: controller,
        enabled: enabled,
        key: ValueKey(valueKey),
        style: const TextStyle(
            color: ColorConstants.dark,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
        maxLength: maxLength,
        maxLines: valueKey == 'TaskDescription' ? 3 : 1,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          filled: true,
          fillColor: ColorConstants.background,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.pink),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Text _textTile(String label) => Text(
        label,
      );
}
