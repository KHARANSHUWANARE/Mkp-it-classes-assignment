/**
 * BankingSystem
 */
public class BankingSystem extends Thread {

    public static double totalbalance=0;
    
   synchronized public void withdraw(double amount) {
   
   synchronized(this) {
        totalbalance=totalbalance-amount;
    }
        

    }
  synchronized public void display() {
        System.out.println("total balance"+totalbalance);
    }
   synchronized public void deposit(double amount) {
        totalbalance=totalbalance+amount;
    }
   
   
    
}

/**
 * Demo
 */
public class Demo {
    public static void main(String[] args) {
        BankingSystem bankingSystem = new BankingSystem();

        Runnable runnable = new Runnable() {

            @Override
            public void run() {
                bankingSystem.deposit(1000);
            }

        };
        Thread deposit = new Thread(runnable);
        Runnable runnable2 = new Runnable() {

            @Override
            public void run() {
                bankingSystem.withdraw(300);
            }

        };
        Thread withdrawThread = new Thread(runnable);
        Runnable runnable3 = new Runnable() {

            @Override
            public void run() {
                bankingSystem.display();
            }

        };
        Thread displayThread = new Thread(runnable);
        deposit.start();
        withdrawThread.start();
        displayThread.start();

        try {
            deposit.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            withdrawThread.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        

    }
}
