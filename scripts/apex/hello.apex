binarySearchTree bsT = new binarySearchTree();
bsT.add(6);
bsT.add(7);
bsT.add(8);
bsT.add(12);
bsT.add(1);
bsT.add(15);
bsT.printTree(bsT.getRoot());

bsT.remove(15,bsT.getRoot());

bsT.printTree(bsT.getRoot());