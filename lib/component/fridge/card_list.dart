import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/widgets/empty_state.dart';

class CardList extends StatelessWidget {
  final List<Widget> cards;
  final String emptyString;
  final IconData icon;
  const CardList({
    super.key,
    required this.icon,
    required this.cards,
    this.emptyString = 'Aucun élément disponible',
  });

  @override
  Widget build(BuildContext context) {
    return cards.isEmpty
        ? EmptyState(
            icon: icon,
            message: emptyString,
          )
        : ListView.separated(
          padding: EdgeInsets.zero,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10, width: 10),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => cards[index],
            itemCount: cards.length,
          );
  }
}
