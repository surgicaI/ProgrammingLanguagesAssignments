import java.util.ArrayList;
import java.util.Iterator;
class ComparableList<T extends Comparable> extends ArrayList<T> implements Comparable<ComparableList<T>>{

	public int compareTo(ComparableList<T> list2){
		Iterator<T> it1 = iterator();
		Iterator<T> it2 = list2.iterator();
		int result = 0;
		while(it1.hasNext() && it2.hasNext()){
			result = it1.next().compareTo(it2.next());
			if(result!=0) return result;
		}
		if(it1.hasNext()) return 1;
		if(it2.hasNext()) return -1;
		return 0;
	}

	@Override
	public String toString(){
		String s="";
		for(T o:this){
			s = s + o + ", " ;
		}
		return s;
	}
}
class A implements Comparable<A>{
	public Integer val = 0;
	public A(Integer x){
		val = x;
	}
	public int compareTo(A a){
		if(val>a.val) return 1;
		if(val<a.val) return -1;
		return 0;
	}
	@Override
	public String toString(){
		return "A<"+String.valueOf(val)+">";
	}
}
class B extends A{
	public Integer val1 = 0, val2 = 0;
	public B(Integer x1, Integer x2){
		super(x1+x2);
		val1 = x1;
		val2 = x2;
	}
	@Override
	public int compareTo(A a){
		if(val>a.val) return 1;
		if(val<a.val) return -1;
		return 0;
	}
	@Override
	public String toString(){
		return "B<"+String.valueOf(val1)+","+String.valueOf(val2)+">";
	}
}
class Part1{
	public static void main(String[] args){
		test();
	}

	public static void test() {
		ComparableList<A> c1 = new ComparableList<A>();
		ComparableList<A> c2 = new ComparableList<A>();
		for(int i = 0; i < 10; i++) {
		    addToCList(new A(i), c1);
		    addToCList(new A(i), c2);
		}
		
		addToCList(new A(12), c1);
		addToCList(new B(6,6), c2);
		
		addToCList(new B(7,11), c1);
		addToCList(new A(13), c2);

		System.out.print("c1: ");
		System.out.println(c1);
		
		System.out.print("c2: ");
		System.out.println(c2);

		switch (c1.compareTo(c2)) {
		case -1: 
		    System.out.println("c1 < c2");
		    break;
		case 0:
		    System.out.println("c1 = c2");
		    break;
		case 1:
		    System.out.println("c1 > c2");
		    break;
		default:
		    System.out.println("Uh Oh");
		    break;
		}
    }
    static <T extends Comparable> void addToCList(T z, ComparableList<T> L){
    	L.add(z);
    }
}