class OInt(var value:Int) extends Ordered[OInt]{
    def compare(that: OInt) :Int = this.value.compare(that.value)
    override def toString() = "<"+value.toString+">"
}

abstract class OTree[T <: Ordered[T]] extends Ordered[OTree[T]]

case class OLeaf[T <: Ordered[T]] (var value:T) extends OTree[T]{
    def compare(that: OTree[T]) :Int = {
    	  that match {
              case OLeaf(thatValue)=> {
              	this.value.compare(thatValue)
              }
              case ONode(nodeList) =>{
              	-1
              } 
          }
    }
}


case class ONode[T <: Ordered[T]] (var nodeList:List[OTree[T]]) extends OTree[T]{
    def compare(that: OTree[T]) :Int = {
    	that match {
              case OLeaf(value)=> {
              	1
              }
              case ONode(thatNodeList) =>{
              	var result = 0;
              	var tempThisList = nodeList
              	var tempThatList = thatNodeList
              	while(result==0 && !tempThisList.isEmpty && !tempThatList.isEmpty){
              		result = tempThisList.head.compare(tempThatList.head)
              		tempThisList = tempThisList.tail
              		tempThatList = tempThatList.tail
              	}
              	if(result==0 && (!tempThisList.isEmpty || !tempThatList.isEmpty)){
              		if(tempThatList.isEmpty) result = 1
              		else result = -1
              	}
              	result
              } 
          }
    }
}


object Part2 {
    def compareTrees[T <: Ordered[T]](oTree1 : OTree[T], oTree2 : OTree[T]) ={
    	val res = oTree1.compare(oTree2)
    	if(res== -1) println("Less");
    	else if(res==0) println("Equal");
    	else if(res==1) println("Greater");
    }

    def test() {
        val tree1 = ONode(List(OLeaf(new OInt(6))))

        val tree2 = ONode(List(OLeaf(new OInt(3)),
                   OLeaf(new OInt(4)), 
                   ONode(List(OLeaf(new OInt(5)))), 
                   ONode(List(OLeaf(new OInt(6)), 
                          OLeaf(new OInt(7))))));

        val treeTree1: OTree[OTree[OInt]] = 
          ONode(List(OLeaf(OLeaf(new OInt(1)))))

        val treeTree2: OTree[OTree[OInt]] = 
          ONode(List(OLeaf(OLeaf(new OInt(1))),
             OLeaf(ONode(List(OLeaf(new OInt(2)), 
                      OLeaf(new OInt(2)))))))


        print("tree1: ")
        println(tree1)
        print("tree2: ")
        println(tree2)
        print("treeTree1: ")
        println(treeTree1)
        print("treeTree2: ")
        println(treeTree2)
        print("Comparing tree1 and tree2: ")
        compareTrees(tree1, tree2)
        print("Comparing tree2 and tree2: ")
        compareTrees(tree2, tree2)
        print("Comparing tree2 and tree1: ")
        compareTrees(tree2, tree1)
        print("Comparing treeTree1 and treeTree2: ")
        compareTrees(treeTree1, treeTree2)
        print("Comparing treeTree2 and treeTree2: ")
        compareTrees(treeTree2, treeTree2)
        print("Comparing treeTree2 and treeTree1: ")
        compareTrees(treeTree2, treeTree1)
    }

    def main(args: Array[String]) {
        test()
    }

}