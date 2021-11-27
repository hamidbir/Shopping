import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/admin_controller.dart';
import 'package:shopping_shoe/utils/constants.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AdminController adminController = Get.put(AdminController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(240, 228, 215, 1),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: const Color.fromRGBO(240, 228, 215, 1),
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
                                          width: 200,
                                          height: 200,
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
                                        maxLength: 10),
                                    _textTile('تعداد کفش'),
                                    _textFormField(
                                        valueKey: 'TaskNumber',
                                        enabled: true,
                                        controller: adminController
                                            .shoeNumberConteroller,
                                        onClick: () {},
                                        maxLength: 2),
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
                                              maxLength: 2),
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
                                                  _showCategoryList(context,
                                                      size, Constants.colorShoe,
                                                      color: true));
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
                                                  child: CircleAvatar(
                                                    radius: 19,
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: CircleAvatar(
                                                      radius: 17,
                                                      backgroundColor: Color(int
                                                          .parse(adminController
                                                              .colors[index])),
                                                    ),
                                                  ),
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

  Widget _showCategoryList(BuildContext context, Size size, List<String> list,
      {bool color = false}) {
    final AdminController admin = Get.find();
    return AlertDialog(
        backgroundColor: Colors.tealAccent,
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
          child: color
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        admin.addColor(index);
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(int.parse(list[index])),
                      ),
                    );
                  },
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length, // Constants.taskCategoryList.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        admin.addCategory(index);

                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading:
                            const Icon(Icons.access_alarm, color: Colors.pink),
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
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
        maxLength: maxLength,
        maxLines: valueKey == 'TaskDescription' ? 3 : 1,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(240, 228, 215, 1),
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
