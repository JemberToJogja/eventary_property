import '../../property/data/dummy_external_properties.dart';
import '../model/external_property.dart';

class PropertyViewModel {
  List<ExternalProperty> get properties {
    return dummyExternalProperties;
  }

  List<ExternalProperty> search(String query) {
    if (query.trim().isEmpty) {
      return properties;
    }

    final keyword = query.toLowerCase();

    return properties.where((property) {
      return property.name.toLowerCase().contains(keyword) ||
          property.category.toLowerCase().contains(keyword) ||
          property.location.toLowerCase().contains(keyword);
    }).toList();
  }
}