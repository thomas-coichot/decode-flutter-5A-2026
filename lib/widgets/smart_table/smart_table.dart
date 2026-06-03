import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../api/models/paginated_response.dart';
import '../../api/repositories/model_repository.dart';
import '../../helpers/exceptions.dart';
import '../../services/toast_service.dart';
import '../fields/text_field.dart';

class SmartTableRoutes<T> {
  final String Function(T)? editRoute;
  final String? addRoute;

  const SmartTableRoutes({
    this.editRoute,
    this.addRoute,
  });
}

class SmartTable<T> extends StatefulWidget {
  const SmartTable({
    required this.repository,
    required this.titleBuilder,
    required this.getId,
    required this.routes,
    this.subtitleBuilder,
    super.key,
  });

  final ModelRepository<T> repository;
  final String Function(T) titleBuilder;
  final Widget Function(T)? subtitleBuilder;
  final String Function(T) getId;
  final SmartTableRoutes routes;

  @override
  State<SmartTable<T>> createState() => _SmartTableState();
}

class _SmartTableState<T> extends State<SmartTable<T>> {
  final TextEditingController _controller = TextEditingController();
  List<T> _items = [];
  int _maxItems = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get hasEditRoute => widget.routes.editRoute != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        if (_isLoading)
          const LinearProgressIndicator(
            minHeight: 2,
          )
        else
          const SizedBox(height: 2),
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: Row(
            spacing: 16,
            crossAxisAlignment: .center,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _controller,
                  label: 'Rechercher...',
                ),
              ),
              IconButton(
                onPressed: () {
                  _loadData();
                },
                icon: const Icon(Icons.search_rounded),
              ),
            ],
          ),
        ),
        if (!_isLoading && _items.isEmpty) const Text('Aucun résultat trouvé'),
        Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (BuildContext ctx, int index) {
              T item = _items[index];

              return ListTile(
                title: Text(widget.titleBuilder(item)),
                subtitle: widget.subtitleBuilder?.call(item),
                trailing: hasEditRoute
                    ? IconButton(
                        onPressed: () {
                          context.push(widget.routes.editRoute!.call(item));
                        },
                        icon: const Icon(Icons.remove_red_eye_rounded),
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }

  void _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      PaginatedResponse<T> items = await widget.repository.getAll(
        queryParams: {
          'search_value': ?_controller.text.isEmpty ? null : _controller.text,
        },
      );

      setState(() {
        _items = items.rows;
        _maxItems = items.count;
        _isLoading = false;
      });
    } on ApiException catch (e) {
      setState(() {
        _isLoading = false;
      });

      ToastService.showToast(e.message);
    }
  }
}
