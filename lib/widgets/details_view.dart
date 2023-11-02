import 'package:flutter/cupertino.dart';

import 'responsive.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: _DetailScreenMobile(),
      desktop: _DetailScreenDesktop(),
    );
  }

}

class _DetailScreenMobile extends StatefulWidget {
  const _DetailScreenMobile({Key? key}) : super(key: key);

  @override
  State<_DetailScreenMobile> createState() => _DetailScreenMobileState();
}

class _DetailScreenMobileState extends State<_DetailScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _DetailScreenDesktop extends StatefulWidget {
  const _DetailScreenDesktop({Key? key}) : super(key: key);

  @override
  State<_DetailScreenDesktop> createState() => _DetailScreenDesktopState();
}

class _DetailScreenDesktopState extends State<_DetailScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
Mobile soll anders sein als Desktop
Bei Mobile soll es eine eigene Seite sein.
Bei Desktop soll es ein PopUp sein. (Wobei der Hintergrund leicht verschwommen wird)
Siehe: https://github.com/BarbosaRT/NetflixClone

Daten zum Anzeigen:
- Titel
- Serien Beschreibung
- Serien Genre
- Produktionsjahr


ev:
- Hautdarsteller
- Regisseur
- Produzenten
- Autoren
- Anzahl Staffeln
- Anzahl Episoden

Buttons für:
- Meine Liste (hinzu/entfernen)
- Like (hat halt wie keine Funktion/kein Nutzen)
- Teilen (eventuell einfach namen der Serie Teilen können aber wohin soll der Link gehen, maybe einfach ein generischer satz[achtung sprache] wie: "Hey, schau dir mal diese Serie an: <Name der Serie> an")





 */