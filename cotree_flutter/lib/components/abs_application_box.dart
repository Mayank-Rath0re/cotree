// File: abs_application_card.dart

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsApplicationCard extends StatefulWidget {
  final Offers? offer;
  final Applications application;
  final int profileId;
  final VoidCallback? onWithdraw;
  const AbsApplicationCard({
    super.key,
    required this.application,
    required this.offer,
    required this.profileId,
    this.onWithdraw,
  });

  @override
  State<AbsApplicationCard> createState() => _AbsApplicationCardState();
}

class _AbsApplicationCardState extends State<AbsApplicationCard>
    with SingleTickerProviderStateMixin {
  bool _isProcessing = false;

  String get _status => widget.application.status;

  int _statusIndex() {
    if (widget.offer!.isActive) {
      return 1;
    }
    switch (_status) {
      case 'Submitted':
        return 0;
      case 'Reviewed':
        return 1;
      case 'Accepted':
        return 2;
      case 'Rejected':
        return 2;
      default:
        return 0;
    }
  }

  Color _statusColor(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    switch (_status) {
      case 'Submitted':
        return Colors.orange;
      case 'Reviewed':
        return theme.headColor;
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return theme.contrastColor;
    }
  }

  Future<void> _confirmWithdraw() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const AbsText(
            displayString: 'Withdraw application?', fontSize: 18, bold: true),
        content: const AbsText(
            displayString:
                'Are you sure you want to withdraw your application? This action cannot be undone.',
            fontSize: 15),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const AbsText(displayString: 'Cancel', fontSize: 15),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const AbsText(displayString: 'Withdraw', fontSize: 15),
          )
        ],
      ),
    );

    if (confirm == true) {
      await _withdraw();
    }
  }

  Future<void> _withdraw() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      if (widget.offer?.id == null) throw Exception('Offer id missing');

      await client.work
          .withdrawApplication(widget.offer!.id!, widget.profileId);

      // call callback to remove from parent list
      widget.onWithdraw?.call();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Application withdrawn')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to withdraw: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).mainColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.contrastColor.withAlpha(4)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // expand or navigate to details - placeholder
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // left avatar / placeholder
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: theme.contrastColor.withAlpha(8),
                        ),
                        child: Center(
                          child: Text(
                            (widget.offer?.title ?? '?').isNotEmpty
                                ? (widget.offer!.title[0].toUpperCase())
                                : '?',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.headColor),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // title & description
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AbsText(
                                displayString:
                                    widget.offer?.title ?? 'Untitled Offer',
                                fontSize: 18,
                                bold: true),
                            const SizedBox(height: 6),
                            Text(
                              widget.offer?.description != null &&
                                      widget.offer!.description.length > 96
                                  ? '${widget.offer!.description.substring(0, 96)}...'
                                  : (widget.offer?.description ?? ''),
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // status chip
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (_isProcessing)
                            const SizedBox(width: 12)
                          else
                            PopupMenuButton<int>(
                              onSelected: (val) async {
                                if (val == 1) await _confirmWithdraw();
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 1,
                                    child: AbsText(
                                        displayString: 'Withdraw Application',
                                        fontSize: 14)),
                              ],
                              child: const Row(
                                children: [
                                  Icon(Icons.more_vert, size: 18),
                                ],
                              ),
                            ),
                          const SizedBox(height: 5),
                          Chip(
                            label:
                                AbsText(displayString: _status, fontSize: 13),
                            backgroundColor: _statusColor(context).withAlpha(8),
                            avatar: Icon(
                              _status == 'Accepted'
                                  ? Icons.check_circle
                                  : _status == 'Rejected'
                                      ? Icons.cancel
                                      : Icons.hourglass_top,
                              size: 18,
                              color: _statusColor(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // steps indicator (simple)
                  Row(
                    children: [
                      _buildStepDot(context, 0, 'Submitted'),
                      _buildLine(context, active: _statusIndex() >= 1),
                      _buildStepDot(context, 1, 'Reviewing'),
                      _buildLine(context, active: _statusIndex() >= 2),
                      _buildStepDot(context, 2,
                          _status == 'Rejected' ? 'Rejected' : 'Accepted'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  if (_isProcessing) ...[
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepDot(BuildContext context, int index, String title) {
    final active = _statusIndex() >= index;
    final color = active
        ? _statusColor(context)
        : Provider.of<ThemeProvider>(context).contrastColor;
    return Column(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(height: 6),
        AbsText(displayString: title, fontSize: 11),
      ],
    );
  }

  Widget _buildLine(BuildContext context, {required bool active}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: active
            ? _statusColor(context)
            : Provider.of<ThemeProvider>(context).contrastColor.withAlpha(2),
      ),
    );
  }
}
