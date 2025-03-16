/// The viewmodels library introduces ViewModelWidget that
/// is responsible to initiate, provide with `provider` and
/// release the view model instance of the given type
///
/// The widget calls overwritten method `build` with the instance of
/// ViewModel class
///
/// If the view model has init method it is called then the model is just created
///
/// If the view model has dismiss method it is called then the model is about
/// to be dismissed
///
/// The widget can be called multiple times with the same class: the only
/// instance will created and passed to all the nested widget
///
/// The view model can be option
library;

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// An interface view model might implement
/// if it has to run some code on initialization
abstract interface class ViewModelWithInit {
  void init(BuildContext context) {}
}

/// An interface view model might implement
/// if it has to run some code on dispose
abstract interface class ViewModelWithDispose {
  void dispose() {}
}

/// An interface view model might implement
/// if it has to run some code on dispose
abstract interface class ViewModelWithProviders {
  List<SingleChildWidget> get providers;
}

abstract class ViewModelWidget<VM> extends StatefulWidget {
  final VM Function(BuildContext) _factory;

  const ViewModelWidget({super.key, required factory}) : _factory = factory;

  Widget build(BuildContext context, VM viewModel);

  @override
  State<ViewModelWidget<VM>> createState() => _ViewModelState<VM>();
}

class _ViewModelState<VM> extends State<ViewModelWidget<VM>> {
  late final VM vm;

/*
  @override
  void initState() {
    super.initState();
  }
 */

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vm = _registry.get<VM>(context, widget._factory);
  }

  @override
  void dispose() {
    if (vm is ViewModelWithDispose) {
      (vm as ViewModelWithDispose).dispose();
    }
    _registry.release<VM>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VM?>(context, listen: false) == null) {
      if (vm is ViewModelWithProviders) {
        final List<SingleChildWidget> providers = [];
        providers.addAll((vm as ViewModelWithProviders).providers);
        providers.add(Provider(create: (_) => vm));
        return MultiProvider(
          providers: providers,
          child: Builder(
            builder: (context) {
              return widget.build(context, vm);
            },
          ),
        );
      } else {
        return Provider<VM>(
          create: (_) => vm,
          child: Builder(
            builder: (context) {
              return widget.build(context, vm);
            },
          ),
        );
      }
    }
    return Builder(
      builder: (context) {
        return widget.build(context, vm);
      },
    );
  }

  static final _ModelViewRegistry _registry = _ModelViewRegistry();
}

class _ModelViewRegistry {
  final Map<Type, _ModelViewReference> _instances = {};

  VM get<VM>(BuildContext context, VM Function(BuildContext) factory) {
    final existing = _instances[VM];
    if (existing == null) {
      final vm = factory(context);
      if (vm is ViewModelWithInit) {
        (vm as ViewModelWithInit).init(context);
      }
      // NOTE: it won't be added if init has thrown
      final ref = _ModelViewReference(vm, context);
      log.finest("instantiated $ref");
      _instances[VM] = ref;
      return vm;
    }
    log.finest("reuse $existing");
    if (existing.counter == 0) {
      log.severe(
          "The $VM instance is referenced 0 times, this should never happen during referencing");
    }
    if (!isDescendant(existing.context, context)) {
      // TODO: it is assumed all the models of the same class are
      // created within the same hierarchy, but it can be extended
      // if the map key contains both ViewModel class and context
      log.severe(
          'The ViewModel\'s context is not a descendant of the context it was instantiated first.');
    }
    final vm = existing.vm as VM;
    existing.counter += 1;
    return vm;
  }

  void release<VM>() {
    final existing = _instances[VM];
    if (existing == null) {
      log.severe("There's no previously initialized view model $VM");
      return;
    }
    log.finest("release $existing");
    if (existing.counter <= 0) {
      log.warning(
          "The $VM instance is referenced ${existing.counter} times, this should never happen during release");
      // try to remove it anyway
      existing.counter = 1;
    }
    existing.counter -= 1;
    if (existing.counter == 0) {
      _instances.remove(VM);
      if (existing is ViewModelWithDispose) {
        (existing as ViewModelWithDispose).dispose();
      }
    }
  }

  static bool isDescendant(BuildContext descendant, BuildContext ancestor) {
    BuildContext? current = descendant;
    while (current != null) {
      if (current == ancestor) {
        return true;
      }
      current = current.findAncestorStateOfType<State>()?.context;
    }
    return false;
  }
}

class _ModelViewReference<VM> {
  final VM vm;
  final BuildContext context;
  int counter = 1;

  _ModelViewReference(this.vm, this.context);

  @override
  String toString() {
    // TODO: implement toString
    return "$VM (reference counter=$counter)";
  }
}

final log = Logger("ViewModel");
