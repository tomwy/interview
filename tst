//多线程实现输出
//信号量
import java.util.concurrent.Semaphore;

public class output{
	private static Semaphore A=new Semaphore(1);
	private static Semaphore B=new Semaphore(1);
	private static Semaphore C=new Semaphore(1);
	
	public static int i=1;
	static class ThreadA extends Thread{
		@Override
		public void run(){
			try {
				for(;i<10;i++){
					A.acquire();
					System.out.print("A"+i);
					B.release();
				}
			} catch (InterruptedException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}
	
	static class ThreadB extends Thread{
		@Override
		public void run(){
			try {
				for(;i<10;i++){
					B.acquire();
					System.out.print("B"+i);
					C.release();
				}
			} catch (InterruptedException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}
	
	static class ThreadC extends Thread{
		@Override
		public void run(){
			try {
				for(;i<10;i++){
					C.acquire();
					System.out.print("C"+i);
					A.release();
				}
			} catch (InterruptedException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) throws InterruptedException{
		B.acquire();
		C.acquire();
		new ThreadA().start();
		new ThreadB().start();
		new ThreadC().start();
	}
}
