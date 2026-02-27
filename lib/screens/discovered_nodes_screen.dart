import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../utils/disconnect_navigation_mixin.dart';
import '../utils/route_transitions.dart';
import '../widgets/quick_switch_bar.dart';
import 'channels_screen.dart';
import 'contacts_screen.dart';
import 'map_screen.dart';

class DiscoveredNodesScreen extends StatefulWidget {
  final bool hideBackButton;

  const DiscoveredNodesScreen({super.key, this.hideBackButton = true});

  @override
  State<DiscoveredNodesScreen> createState() => _DiscoveredNodesScreenState();
}

class _DiscoveredNodesScreenState extends State<DiscoveredNodesScreen>
    with DisconnectNavigationMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MeshCoreConnector>(
      builder: (context, connector, child) {
        // Keep navigation behavior consistent with other connected tabs.
        if (!checkConnectionAndNavigate(connector)) {
          return const SizedBox.shrink();
        }

        final allNodes = List<Contact>.from(connector.discoveredNodes)
          ..sort((a, b) => b.lastSeen.compareTo(a.lastSeen));
        final query = _searchQuery.trim().toLowerCase();
        final nodes = query.isEmpty
            ? allNodes
            : allNodes.where((node) {
                final name = node.name.toLowerCase();
                final type = node.typeLabel.toLowerCase();
                final shortKey = node.shortPubKeyHex.toLowerCase();
                final fullKey = node.publicKeyHex.toLowerCase();
                return name.contains(query) ||
                    type.contains(query) ||
                    shortKey.contains(query) ||
                    fullKey.contains(query);
              }).toList();
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (connector.isConnected) {
              _handleQuickSwitch(0, context);
              return;
            }
            if (!didPop && Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Discovered Nodes'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: _buildLeading(context, connector),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search discovered nodes...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: nodes.isEmpty
                      ? _buildEmptyState(context)
                      : ListView.separated(
                          itemCount: nodes.length,
                          separatorBuilder: (_, _) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final node = nodes[index];
                            return ListTile(
                              leading: _nodeAvatar(node),
                              title: Text(
                                node.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                '${node.typeLabel} • ${node.shortPubKeyHex}\n${_lastSeenLabel(node.lastSeen)}',
                              ),
                              isThreeLine: true,
                              trailing: Wrap(
                                spacing: 4,
                                children: [
                                  IconButton(
                                    tooltip: context.l10n.common_add,
                                    icon: const Icon(Icons.person_add_alt_1),
                                    onPressed: () => _addToContacts(
                                      context,
                                      connector,
                                      node,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: context.l10n.common_delete,
                                    icon: const Icon(Icons.close),
                                    onPressed: () =>
                                        connector.dismissDiscoveredNode(node),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            bottomNavigationBar: SafeArea(
              top: false,
              child: QuickSwitchBar(
                selectedIndex: 2,
                onDestinationSelected: (index) =>
                    _handleQuickSwitch(index, context),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleQuickSwitch(int index, BuildContext context) {
    if (index == 2) return;
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          buildQuickSwitchRoute(const ContactsScreen(hideBackButton: true)),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          buildQuickSwitchRoute(const ChannelsScreen(hideBackButton: true)),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          buildQuickSwitchRoute(const MapScreen(hideBackButton: true)),
        );
        break;
    }
  }

  Widget? _buildLeading(BuildContext context, MeshCoreConnector connector) {
    if (connector.isConnected) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () => _handleQuickSwitch(0, context),
      );
    }
    if (widget.hideBackButton) return null;
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () => Navigator.of(context).maybePop(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'No discovered nodes yet.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _nodeAvatar(Contact node) {
    final IconData icon = switch (node.type) {
      2 => Icons.cell_tower,
      3 => Icons.groups,
      4 => Icons.sensors,
      _ => Icons.person,
    };
    return CircleAvatar(child: Icon(icon));
  }

  String _lastSeenLabel(DateTime lastSeen) {
    final now = DateTime.now();
    final diff = now.difference(lastSeen);
    if (diff.inMinutes < 1) return 'Seen just now';
    if (diff.inMinutes < 60) return 'Seen ${diff.inMinutes} min ago';
    if (diff.inHours < 24) return 'Seen ${diff.inHours} h ago';
    return 'Seen ${diff.inDays} d ago';
  }

  Future<void> _addToContacts(
    BuildContext context,
    MeshCoreConnector connector,
    Contact node,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await connector.addDiscoveredNodeToContacts(node);
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('${node.name} added to contacts')),
      );
    } catch (e) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to add ${node.name}: $e')),
      );
    }
  }
}
