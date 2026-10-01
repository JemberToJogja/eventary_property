import 'package:eventary_prototype/eksternal/home/model/external_property.dart';

const List<ExternalProperty> dummyExternalProperties = [
  ExternalProperty(
    id: 'EXT-001',
    name: 'Mall ABC',
    category: 'Mall',
    location: 'Jakarta Selatan',
    address: 'Jl. Sudirman No. 25, Jakarta Selatan',
    area: '45.000 m²',
    status: 'Available',
    price: 'Mulai dari Rp 25.000.000 / hari',
    image:
        'https://images.unsplash.com/photo-1519567241046-7f570eee3a0c?auto=format&fit=crop&w=1200&q=80',
    gallery: [
      'https://images.unsplash.com/photo-1519567241046-7f570eee3a0c?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1601598851547-4302969d2f7b?auto=format&fit=crop&w=1200&q=80',
    ],
    shortDescription:
        'Modern shopping and lifestyle destination for retail, events, and exhibitions.',
    description:
        'Mall ABC merupakan pusat lifestyle dan commercial destination '
        'yang menyediakan berbagai ruang untuk retail, exhibition, event, '
        'dan aktivitas bisnis. Berlokasi di kawasan strategis Jakarta Selatan '
        'dengan akses transportasi yang mudah.',
    facilities: [
      'Parking Area',
      'Security 24 Hours',
      'Loading Dock',
      'Food Court',
      'Public Wi-Fi',
      'Restroom',
      'Prayer Room',
      'Event Space',
    ],
    spaces: [
      ExternalSpace(
        name: 'Main Exhibition Hall',
        area: '5.000 m²',
        capacity: '2.000 people',
        price: 'Rp 75.000.000 / hari',
      ),
      ExternalSpace(
        name: 'Event Ballroom',
        area: '2.500 m²',
        capacity: '800 people',
        price: 'Rp 45.000.000 / hari',
      ),
      ExternalSpace(
        name: 'Outdoor Area',
        area: '3.000 m²',
        capacity: '1.500 people',
        price: 'Rp 35.000.000 / hari',
      ),
    ],
  ),
  ExternalProperty(
    id: 'EXT-002',
    name: 'Mall XYZ',
    category: 'Mall',
    location: 'Jakarta Barat',
    address: 'Jl. Puri Indah Raya No. 8, Jakarta Barat',
    area: '32.500 m²',
    status: 'Available',
    price: 'Mulai dari Rp 18.000.000 / hari',
    image:
        'https://images.unsplash.com/photo-1581417478175-a9ef18f210c2?auto=format&fit=crop&w=1200&q=80',
    gallery: [
      'https://images.unsplash.com/photo-1581417478175-a9ef18f210c2?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1567449303078-57ad995bd17b?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1577083552431-6e5fd01aa342?auto=format&fit=crop&w=1200&q=80',
    ],
    shortDescription:
        'Strategic commercial property with flexible spaces for business and events.',
    description:
        'Mall XYZ menghadirkan ruang komersial modern yang dapat digunakan '
        'untuk berbagai kebutuhan bisnis dan event. Properti memiliki area '
        'yang fleksibel untuk exhibition, brand activation, dan kegiatan komunitas.',
    facilities: [
      'Parking Area',
      'Escalator',
      'Security',
      'Loading Area',
      'Food Court',
      'Restroom',
      'ATM Center',
      'Event Area',
    ],
    spaces: [
      ExternalSpace(
        name: 'Atrium Area',
        area: '1.500 m²',
        capacity: '700 people',
        price: 'Rp 30.000.000 / hari',
      ),
      ExternalSpace(
        name: 'Exhibition Space',
        area: '3.000 m²',
        capacity: '1.200 people',
        price: 'Rp 50.000.000 / hari',
      ),
      ExternalSpace(
        name: 'Outdoor Plaza',
        area: '2.000 m²',
        capacity: '900 people',
        price: 'Rp 25.000.000 / hari',
      ),
    ],
  ),
  ExternalProperty(
    id: 'EXT-003',
    name: 'Event Venue A',
    category: 'Event Venue',
    location: 'Jakarta Pusat',
    address: 'Jl. Gatot Subroto No. 18, Jakarta Pusat',
    area: '12.000 m²',
    status: 'Available',
    price: 'Mulai dari Rp 20.000.000 / hari',
    image:
        'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?auto=format&fit=crop&w=1200&q=80',
    gallery: [
      'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&w=1200&q=80',
    ],
    shortDescription:
        'Dedicated event venue for exhibitions, conferences, festivals, and corporate events.',
    description: 'Event Venue A merupakan dedicated event venue yang dirancang '
        'untuk berbagai kebutuhan acara berskala kecil hingga besar. '
        'Venue dapat digunakan untuk exhibition, conference, festival, '
        'corporate event, dan private event.',
    facilities: [
      'Main Hall',
      'Stage',
      'Sound System',
      'Parking Area',
      'VIP Room',
      'Security',
      'Loading Dock',
      'Public Wi-Fi',
    ],
    spaces: [
      ExternalSpace(
        name: 'Main Hall',
        area: '4.000 m²',
        capacity: '2.500 people',
        price: 'Rp 60.000.000 / hari',
      ),
      ExternalSpace(
        name: 'Conference Room',
        area: '800 m²',
        capacity: '400 people',
        price: 'Rp 20.000.000 / hari',
      ),
      ExternalSpace(
        name: 'Outdoor Event Area',
        area: '5.000 m²',
        capacity: '3.000 people',
        price: 'Rp 45.000.000 / hari',
      ),
    ],
  ),
  ExternalProperty(
    id: 'EXT-004',
    name: 'Office Tower A',
    category: 'Office',
    location: 'Jakarta Selatan',
    address: 'Jl. TB Simatupang No. 12, Jakarta Selatan',
    area: '18.000 m²',
    status: 'Available',
    price: 'Mulai dari Rp 15.000.000 / bulan',
    image:
        'https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=1200&q=80',
    gallery: [
      'https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1200&q=80',
    ],
    shortDescription:
        'Premium office space located in a strategic business district.',
    description:
        'Office Tower A menyediakan ruang perkantoran modern untuk perusahaan '
        'dan organisasi yang membutuhkan lokasi strategis dengan fasilitas profesional.',
    facilities: [
      '24 Hours Security',
      'Lobby',
      'Reception',
      'Parking Area',
      'Meeting Room',
      'Elevator',
      'Public Wi-Fi',
      'Cafeteria',
    ],
    spaces: [
      ExternalSpace(
        name: 'Office Floor',
        area: '1.200 m²',
        capacity: '150 people',
        price: 'Rp 120.000.000 / bulan',
      ),
      ExternalSpace(
        name: 'Meeting Space',
        area: '150 m²',
        capacity: '40 people',
        price: 'Rp 5.000.000 / hari',
      ),
    ],
  ),
  ExternalProperty(
    id: 'EXT-005',
    name: 'Convention Hall',
    category: 'Event Venue',
    location: 'Jakarta Pusat',
    address: 'Jl. Kemayoran Raya No. 5, Jakarta Pusat',
    area: '8.500 m²',
    status: 'Maintenance',
    price: 'Mulai dari Rp 40.000.000 / hari',
    image:
        'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1200&q=80',
    gallery: [
      'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=1200&q=80',
    ],
    shortDescription:
        'Large convention space for exhibitions, conferences, and large-scale events.',
    description:
        'Convention Hall merupakan venue dengan kapasitas besar yang ditujukan '
        'untuk conference, exhibition, seminar, dan berbagai kegiatan berskala '
        'nasional maupun internasional.',
    facilities: [
      'Main Hall',
      'Stage',
      'Audio System',
      'VIP Lounge',
      'Parking Area',
      'Security',
      'Loading Dock',
      'Restroom',
    ],
    spaces: [
      ExternalSpace(
        name: 'Convention Hall',
        area: '5.000 m²',
        capacity: '3.000 people',
        price: 'Rp 80.000.000 / hari',
      ),
      ExternalSpace(
        name: 'Meeting Hall',
        area: '1.000 m²',
        capacity: '500 people',
        price: 'Rp 25.000.000 / hari',
      ),
    ],
  ),
  ExternalProperty(
    id: 'EXT-006',
    name: 'Commercial Center',
    category: 'Commercial',
    location: 'Jakarta Utara',
    address: 'Jl. Pantai Indah Kapuk No. 10, Jakarta Utara',
    area: '25.000 m²',
    status: 'Available',
    price: 'Mulai dari Rp 20.000.000 / bulan',
    image:
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80',
    gallery: [
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1528698827591-e19ccd7bc23d?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&w=1200&q=80',
    ],
    shortDescription:
        'Flexible commercial property suitable for various business activities.',
    description:
        'Commercial Center merupakan kawasan komersial yang menyediakan ruang '
        'untuk retail, showroom, tenant, brand activation, dan kegiatan bisnis lainnya.',
    facilities: [
      'Parking Area',
      'Security',
      'Loading Area',
      'Public Wi-Fi',
      'Restroom',
      'Food Area',
      'Outdoor Space',
      'CCTV',
    ],
    spaces: [
      ExternalSpace(
        name: 'Retail Space',
        area: '500 m²',
        capacity: '100 people',
        price: 'Rp 20.000.000 / bulan',
      ),
      ExternalSpace(
        name: 'Showroom',
        area: '1.000 m²',
        capacity: '250 people',
        price: 'Rp 40.000.000 / bulan',
      ),
    ],
  ),
];
