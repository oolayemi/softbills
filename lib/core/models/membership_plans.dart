class MPlans {
  String? planName;
  String? amount;
  String? commission;
  String? point;
  String? depth;
  String? slug;

  MPlans({
    this.planName,
    this.amount,
    this.commission,
    this.point,
    this.depth,
    this.slug
  });

  static List<MPlans> plans = [
    MPlans(
      planName: 'Diamond Membership',
      amount: '10,000.00',
      commission: '20% Commission',
      point: '100 Reward Points',
      depth: '10 Generation Referrer Depth',
      slug: '5448282315f8abfae1ad3f'
    ),
    MPlans(
      planName: 'Gold Membership',
      amount: '7,500.00',
      commission: '20% Commission',
      point: '75 Reward Points',
      depth: '10 Generation Referrer Depth',
      slug: '7227649995f8abfae1ad3e'
    ),
    MPlans(
      planName: 'Silver Membership',
      amount: '5,000.00',
      commission: '20% Commission',
      point: '50 Reward Points',
      depth: '6 Generation Referrer Depth',
      slug: '7559582765f8abfae1ad3d'
    ),
    MPlans(
      planName: 'Bronze Membership',
      amount: '2,500.00',
      commission: '20% Commission',
      point: '25 Reward Points',
      depth: '4 Generation Referrer Depth',
      slug: '18593423615f8abfae1ad3c'
    ),
    MPlans(
      planName: 'Basic Membership',
      amount: '1,000.00',
      commission: '20% Commission',
      point: '10 Reward Points',
      depth: '2 Generation Referrer Depth',
      slug: '15892240875f8abfae1ad39'
    ),
  ];
}