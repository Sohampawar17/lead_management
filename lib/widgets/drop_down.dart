
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CdropDown extends StatelessWidget {
  const CdropDown({
    super.key,
    required this.dropdownButton,
  });

  final Widget dropdownButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).hoverColor,
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
      ),
      child: dropdownButton,
    );
  }
}

class CustomDropdownButton2 extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String hintText;
  final String labelText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final InputDecoration? searchInputDecoration;
  final Widget? searchInnerWidget;
  final double? searchInnerWidgetHeight;
  final TextEditingController? searchController;
  final IconData? prefixIcon;

  const CustomDropdownButton2({super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.searchInputDecoration,
    this.searchInnerWidget,
    this.searchInnerWidgetHeight,
    this.searchController, this.prefixIcon,required  this.labelText, this.validator,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
    
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),

        border: Border.all(
          width: 2,
         color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: DropdownSearch<String>(

              popupProps:  PopupProps.bottomSheet(
                fit: FlexFit.tight,

showSearchBox: true,showSelectedItems: true,searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
fillColor: Colors.white,
filled: true,
                  labelText: 'Search',
                  hintText: 'Search here ..',
                  prefixIcon: const Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                      const BorderSide(color: Colors.blue, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                      const BorderSide(color: Colors.grey, width: 2)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.black45, width: 2)),
                ),
),
 itemBuilder: (
          BuildContext context,
          String? item,
          bool isSelected,
        ) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:Container(
            width: 20, // Adjust the width as needed
            height: 20, // Adjust the height as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(

                width: 1.0,
              ),
              color: isSelected ? Colors.blueAccent : Colors.transparent,
            ),
          ),
                  ),
                         Expanded(
                          flex: 6,
                           child: ListTile(
                                           title: Text(
                                             item ?? '',
                                             style: TextStyle(
                                               fontWeight: FontWeight.w500,
                                               color: isSelected ? Colors.blue : Colors.black,
                                             ),
                                           ),
                                           selected: isSelected,
                                         ),
                         ),
                ],
              ),

              const Divider(
             thickness: 1,
                color: Colors.black45,
              ),
            ],
          );
        },
              ),

              items:items,
              dropdownDecoratorProps:  DropDownDecoratorProps(
          dropdownSearchDecoration:InputDecoration(
            fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        labelStyle: const TextStyle(
          color: Colors.black54, // Customize label text color
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize hint text color
        ),
        border: InputBorder.none
      ),
              ),
              onChanged: onChanged,
              selectedItem:value,
        validator: validator,
          ),

    );
  }
}





class CustomDropdownButton extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic>? value;
  final String hintText;
  final String labelText;
  final void Function(Map<String, dynamic>?)? onChanged;
  final String? Function(Map<String, dynamic>?)? validator;
  final IconData? prefixIcon;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.prefixIcon,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              width: 1,
              color: Colors.grey,
              style: BorderStyle.solid,
            ),
          ),
          child: DropdownButtonFormField<Map<String, dynamic>>(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem<Map<String, dynamic>>(
                value: item,
                child: Text(item['party_name']),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              labelStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
            validator: validator,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index]['party_name']),
                onTap: () {
                  onChanged!(items[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}



class CustomMultiDropdownButton extends StatelessWidget {
  final List<String> items;
  final List<String> value;
  final String hintText;
  final String labelText;
  final void Function(List<String>?)? onChanged;
  final String? Function(String?)? validator;
  final InputDecoration? searchInputDecoration;
  final Widget? searchInnerWidget;
  final double? searchInnerWidgetHeight;
  final TextEditingController? searchController;
  final IconData? prefixIcon;

  const CustomMultiDropdownButton({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    required this.value,
    this.searchInputDecoration,
    this.searchInnerWidget,
    this.searchInnerWidgetHeight,
    this.searchController,
    this.prefixIcon,
    required this.labelText,
    this.validator,
  });


  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: DropdownSearch<String>.multiSelection(
        popupProps:  PopupPropsMultiSelection<String>.bottomSheet(
          fit: FlexFit.tight,
          showSearchBox: true,
          showSelectedItems: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Search here ..',
              prefixIcon: const Icon(Icons.search),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.black45, width: 2),
              ),
            ),
          ),

          itemBuilder: (
              BuildContext context,
              String? item,
              bool isSelected,
              ) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(item ?? ""),
            );
          },),
        items:items,
        dropdownDecoratorProps:  DropDownDecoratorProps(
          dropdownSearchDecoration:InputDecoration(

              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              labelText: labelText,
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              labelStyle: const TextStyle(
                color: Colors.black54, // Customize label text color
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              hintStyle: const TextStyle(
                color: Colors.grey, // Customize hint text color
              ),
              border: InputBorder.none
          ),
        ),
        onChanged: onChanged,
        selectedItems:value,

      ),
    );
  }
}