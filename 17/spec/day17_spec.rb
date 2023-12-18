require_relative '../lib/day17'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe 'Node class' do
  before :each do
    create_nodes(example)
  end

  after :each do
    Object.send(:remove_const, 'Node')
    load 'lib/day17.rb'
  end

  describe '#set_shortest_distance' do
    it 'should set the parent and distance if not set yet' do
      node = Node.all[[0, 1]]
      parent = Node.all[[0, 0]]
      node.set_shortest_distance(parent, 4)
      expect(node.parent).to eq parent
      expect(node.distance).to eq 4
      expect(Node.unvisited).to include node
    end

    it 'should set the parent and distance if it has been set before with a taller distance' do
      node = Node.all[[0, 1]]
      parent = Node.all[[0, 0]]
      node.set_shortest_distance(Node.all[[0, 2]], 5)
      node.set_shortest_distance(parent, 4)
      expect(node.parent).to eq parent
      expect(node.distance).to eq 4
    end

    it 'should not set the parent and distance if it has been set before with a lower distance' do
      node = Node.all[[0, 1]]
      parent = Node.all[[0, 0]]
      node.set_shortest_distance(Node.all[[0, 2]], 3)
      node.set_shortest_distance(parent, 4)
      expect(node.parent).not_to eq parent
      expect(node.distance).to eq 3
    end
  end

  describe '#visit!' do
    it 'should mark the node as visited' do
      node = Node.all[[0, 0]]
      node.visit!
      expect(node.visited).to eq true
    end

    it 'should remove the node from the unvisited nodes' do
      node = Node.all[[0, 0]]
      node.set_shortest_distance(Node.all[[0, 1]], 1) # add it to the unvisited nodes
      node.visit!
      expect(node.visited).to eq true
    end
  end
end

describe 'Full implementation' do
  after :each do
    Object.send(:remove_const, 'Node')
    load 'lib/day17.rb'
  end

  describe '#solve1' do
    it 'should work with a smaller test' do
      test = "11599\n99199\n99199\n99199\n99111"
      expect(solve1(test)).to eq 16
    end

    it 'should work with the example' do
      expect(solve1(example)).to eq 102
    end
  end
end
