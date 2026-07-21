import 'package:flutter/material.dart';
import 'package:noorah/features/setup/capital_city.dart';
import 'package:noorah/features/setup/capital_city_repository.dart';

class CapitalCityField extends StatefulWidget {
  const CapitalCityField({
    super.key,
    required this.controller,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;

  @override
  State<CapitalCityField> createState() => _CapitalCityFieldState();
}

class _CapitalCityFieldState extends State<CapitalCityField> {
  late final Future<List<CapitalCity>> _citiesFuture;
  List<CapitalCity> _cities = fallbackCapitalCities;

  @override
  void initState() {
    super.initState();
    _citiesFuture = CapitalCityRepository().getCapitalCities();
    _citiesFuture.then((cities) {
      if (mounted && cities.isNotEmpty) {
        setState(() {
          _cities = cities;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CapitalCity>>(
      future: _citiesFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;

        return Autocomplete<CapitalCity>(
          displayStringForOption: (option) => option.displayName,
          initialValue: TextEditingValue(text: widget.controller.text),
          optionsBuilder: (textEditingValue) {
            final query = textEditingValue.text.trim().toLowerCase();
            if (query.isEmpty) return _cities.take(12);

            return _cities
                .where((city) {
                  return city.city.toLowerCase().contains(query) ||
                      city.country.toLowerCase().contains(query) ||
                      city.displayName.toLowerCase().contains(query);
                })
                .take(20);
          },
          onSelected: (city) {
            widget.controller.text = city.displayName;
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
                if (textEditingController.text != widget.controller.text) {
                  textEditingController.text = widget.controller.text;
                }

                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  textInputAction: widget.textInputAction,
                  decoration: InputDecoration(
                    labelText: 'Capital city',
                    hintText: 'Search Cairo, Egypt',
                    prefixIcon: const Icon(Icons.location_city_outlined),
                    suffixIcon: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(14),
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : const Icon(Icons.search_rounded),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final normalized = value?.trim().toLowerCase() ?? '';
                    final hasMatch = _cities.any(
                      (city) => city.displayName.toLowerCase() == normalized,
                    );

                    if (normalized.isEmpty) {
                      return 'Please choose your capital city';
                    }

                    if (!hasMatch) {
                      return 'Please select a city from the list';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    onFieldSubmitted();
                    widget.onSubmitted?.call();
                  },
                  onChanged: (value) {
                    if (widget.controller.text != value) {
                      widget.controller.text = value;
                    }
                  },
                );
              },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 280,
                    maxWidth: 460,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.place_outlined),
                        title: Text(option.city),
                        subtitle: Text(option.country),
                        onTap: () => onSelected(option),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
