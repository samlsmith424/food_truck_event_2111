require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
  let(:event) {Event.new("South Pearl Street Farmers Market")}

  it 'exists' do
    expect(event).to be_a(Event)
  end

  it 'has attributes' do
    expect(event.name).to eq("South Pearl Street Farmers Market")
    expect(event.food_trucks).to eq([])
  end

  describe 'iteration 2' do
    let(:food_truck1) {FoodTruck.new("Rocky Mountain Pies")}
    let(:item1) {Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})}
    let(:item2) {Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})}
    let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
    let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}
    let(:food_truck2) {FoodTruck.new("Ba-Nom-a-Nom")}
    let(:food_truck3) {FoodTruck.new("Palisade Peach Shack")}

    it 'can stock more items' do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
    end

    it '#food_truck_names' do
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it '#food_trucks_that_sell a specific item' do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
      expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    end

    describe 'iteration 3' do
      it '#total_inventory' do
        food_truck1.stock(item1, 35)
        food_truck1.stock(item2, 7)
        food_truck2.stock(item4, 50)
        food_truck2.stock(item3, 25)
        food_truck3.stock(item1, 65)
        food_truck3.stock(item3, 10)
        event.add_food_truck(food_truck1)
        event.add_food_truck(food_truck2)
        event.add_food_truck(food_truck3)

        expected = {
          item1 => {quantity: 100, food_trucks: [food_truck1, food_truck3]},
          item2 => {quantity: 7, food_trucks: [food_truck1]},
          item3 => {quantity: 50, food_trucks: [food_truck2]},
          item4 => {quantity: 35, food_trucks: [food_truck2, food_truck3]}
        }
        expect(event.total_inventory).to eq(expected)
      end

      it '#overstocked_items' do
        food_truck1.stock(item1, 35)
        food_truck1.stock(item2, 7)
        food_truck2.stock(item4, 50)
        food_truck2.stock(item3, 25)
        food_truck3.stock(item1, 65)
        food_truck3.stock(item3, 10)
        event.add_food_truck(food_truck1)
        event.add_food_truck(food_truck2)
        event.add_food_truck(food_truck3)
        expect(event.overstocked_items).to eq([item1])
      end

      it '#sorted_item_list' do
        food_truck1.stock(item1, 35)
        food_truck1.stock(item2, 7)
        food_truck2.stock(item4, 50)
        food_truck2.stock(item3, 25)
        food_truck3.stock(item1, 65)
        food_truck3.stock(item3, 10)
        event.add_food_truck(food_truck1)
        event.add_food_truck(food_truck2)
        event.add_food_truck(food_truck3)
        expect(event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
      end
    end
  end
end
