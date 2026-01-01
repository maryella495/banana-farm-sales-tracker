import 'package:flutter/material.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> allSales = [
    {
      "name": "Maria Cruz",
      "date": "Dec 5, 2025",
      "quantity": "50",
      "pricePerKg": "45",
      "total": "₱2,000",
    },
    {
      "name": "Pedro Garcia",
      "date": "Dec 5, 2025",
      "quantity": "50",
      "pricePerKg": "45",
      "total": "₱2,000",
    },
  ];

  List<Map<String, String>> filteredSales = [];

  @override
  void initState() {
    super.initState();
    filteredSales = allSales;
    _searchController.addListener(_filterSales);
  }

  void _filterSales() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredSales = allSales
          .where((sale) => sale["name"]!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _deleteSale(int index) {
    setState(() {
      filteredSales.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          "Sales Archive",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search by buyer name...",
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // Sales count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${filteredSales.length} sales found",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Sales list
          Expanded(
            child: ListView.builder(
              itemCount: filteredSales.length,
              itemBuilder: (context, index) {
                final sale = filteredSales[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: avatar + name/date + price
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFBCDABB),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFF0A6305),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sale["name"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 14,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      sale["date"]!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              sale["total"]!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0A6305),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Row 2: quantity and rate
                        Row(
                          children: [
                            Icon(
                              Icons.balance,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "${sale["quantity"]} kg    •    ₱${sale["pricePerKg"]}/kg",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Divider spanning full width
                        const Divider(
                          height: 20,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),

                        // Row 3: delete icon + text
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteSale(index),
                              ),
                              const Text(
                                "Delete",
                                style: TextStyle(
                                  color: Color(0xFFB60D15),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
