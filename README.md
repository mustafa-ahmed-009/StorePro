# **StorePro– Full Store Management App Using Flutter**  

⚠️ **Disclaimer:** This version of the code does not include all features, as the full version is a paid product.  

I’d like to share my recent freelance project!  
This project is a **complete store management application** built with **Flutter**.  

## **Project Details:**  

- **Architecture:** MVVM  
- **Backend:** SQLite using the `sqflite` package  
- **State Management:** BLoC  

I’ve decided to split the project into multiple videos since it’s quite large. Below are the features covered in the **first video**:  

### **Features (Part 1):**  

*Click on the image to watch on YouTube*  

[![Watch the video](https://img.youtube.com/vi/yqCFQivl3eY/0.jpg)](https://www.youtube.com/watch?v=yqCFQivl3eY)  

1. **Authentication with different user roles and permissions.**  

2. **Main dashboard for easy access to the following features:**  
   - Add an **invoice (customer price).**  
   - Add a **wholesale invoice (trader price).**  
   - Add a **sales return invoice.**  
   - Add an **entry permit for data input.**  
   - View **low-stock products.**  
   - View **invoice details** (such as total amount, paid amount, and remaining balance for premium customers).  

3. **Full CRUD operations are supported** for **warehouses, categories, and products.**  

4. **Invoice management with the following conditions:**  
   - The user **cannot increase an item’s quantity** in an invoice if it exceeds the available stock.  
   - The user **cannot add an item** with a quantity of **zero** to the invoice.  
   - The user can apply a **custom discount percentage** to the invoice.  

### **Features (Part 2):**  

*Click on the image to watch on YouTube*  

[![Watch the video](https://img.youtube.com/vi/ZtwRdzbah7A/0.jpg)](https://www.youtube.com/watch?v=ZtwRdzbah7A)  

1. **Fully responsive application.**  

2. **Search feature for finding products by name.**  

3. **Trader invoice feature with the following conditions:**  
   - Product price is set at the trader price.  
   - Partial payment is allowed for premium customers.  

4. **Display list of premium customers.**  

5. **View invoices for each customer with total remaining balances.**  

6. **Ability to add payments from premium customers to settle invoice balances.**  

7. **Return invoices feature.**  

8. **Entry permit feature with the ability to view current stock and specify new quantities.**  

9. **View all entry permits by date with full details for each permit.**  

10. **View low-stock products for each category.**  

11. **Dedicated section for products customers wish to purchase later but are currently out of stock.**  

12. **Invoice management with options to view invoices for the current day and current month.**  

13. **Daily expense tracking feature.**  

14. **Different user permissions:**  
   - Example: Regular users **cannot delete any items**.  
