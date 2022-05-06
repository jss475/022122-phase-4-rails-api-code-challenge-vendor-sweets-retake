puts '🍪 Seeding vendors...'

Vendor.create(
  [
    { name: 'Insomnia Cookies' },
    { name: 'Cookies Cream' },
    { name: 'Carvel' },
    { name: "Gregory's Coffee" },
    { name: 'Duane Park Patisserie' },
    { name: 'Tribeca Treats' },
  ],
)

puts '🍪 Seeding sweets...'
Sweet.create(
  [
    { name: 'Chocolate Chip Cookie' },
    { name: 'Chocolate Chunk Cookie' },
    { name: 'M&Ms Cookie' },
    { name: 'White Chocolate Cookie' },
    { name: 'Brownie' },
    { name: 'Peanut Butter Ice Cream Cake' },
  ],
)

puts '🍪 Seeding vendor sweets...'
Vendor.all.each do |vendor|
  rand(2..4).times do
    # get a random sweet
    sweet = Sweet.find(Sweet.pluck(:id).sample)

    VendorSweet.create!(
      sweet_id: sweet.id,
      vendor_id: vendor.id,
      price: rand(2..10) * 50,
    )
  end
end

puts '🍪 Done seeding!'
