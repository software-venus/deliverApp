import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:entrega/pages/home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CorreiosTrackingPage extends StatefulWidget {

  HomePageState homePageState;
  bool dobleClosed;

  CorreiosTrackingPage({Key? key, required this.homePageState, required this.dobleClosed})
      : super(key: key);
  
  @override
  State<CorreiosTrackingPage> createState() => _CorreiosTrackingPageState();

  
}

class _CorreiosTrackingPageState extends State<CorreiosTrackingPage> {
  final trackingCodeController = TextEditingController();
  List<Eventos> events = [];
  String errorMessage = '';

  Future<void> trackPackage() async {
    final tracker = CorreiosRastreio();
    final code = trackingCodeController.text.trim().toUpperCase();

    try {
      final result = await tracker.rastrearEncomenda(code);
      print(result);
      setState(() {
        events = result.eventos;
        print(events);
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        events = [];
        errorMessage = 'Erro ao rastrear: ${e.toString()}';
        print(errorMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rastrear Correios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: trackingCodeController,
              decoration: const InputDecoration(
                labelText: 'Código de rastreio (ex: LL123456789BR)',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: trackPackage,
              child: const Text('Rastrear'),
            ),
            const SizedBox(height: 24),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            if (events.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return ListTile(
                      title: Text(event.descricao),
                      subtitle: Text('${event.data} - ${event.tipo}'),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
