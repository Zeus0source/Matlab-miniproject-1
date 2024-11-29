
# Ticket Booking System (MATLAB App Designer)

## Project Overview
The **Ticket Booking System** is a graphical user interface (GUI) application developed using MATLAB App Designer. It facilitates ticket booking, cancellation, and seat management for flights, trains, and buses. The system includes real-time seat availability updates, dynamic pricing, and a live clock display. Users can also save and load booking data for future use.

## Features
- **Ticket Booking:** Book tickets by entering personal details and selecting the desired transport mode, date, time, and destination.
- **Dynamic Seat Management:** Real-time updates of seat availability for each transport mode.
- **Ticket Cancellation:** Cancel existing bookings and update seat availability automatically.
- **Price Calculation:** Calculate ticket prices based on the selected transport mode and destination.
- **Data Persistence:** Save and load booking data using `.csv` files.
- **Real-Time Clock:** Displays the current time, updated every second.

## Installation Instructions
### Prerequisites
- MATLAB R2016a or later.
- App Designer (included in MATLAB).

### Steps to Run the Application
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/TicketBookingSystem.git
    ```
2. Open MATLAB and navigate to the project directory.
3. Open the `TicketBookingSystem.mlapp` file in MATLAB App Designer.
4. Click the **Run** button to launch the application.

## Usage Guide
1. **Booking a Ticket:** 
    - Enter your **Name** and **Contact** information.
    - Choose a **Mode of Transport** (Flight, Train, Bus).
    - Click **Book Ticket** to confirm.

2. **Canceling a Booking:** 
    - Select a booking from the table.
    - Click **Cancel Booking** to remove it and free up a seat.

3. **Saving and Loading Data:** 
    - Use the **Save Data** button to store bookings in a `.csv` file.
    - Use the **Load Data** button to retrieve saved bookings.

## Project Structure
- `TicketBookingSystem.mlapp`: Main application file.
- `sample_bookings.csv`: Sample booking data file.
- 
## Future Enhancements
- Integration with online payment systems.
- User authentication for secure booking.
- Multi-user access and web deployment using MATLAB Web App Server.
- UI improvements with custom themes and responsive design.

## Contact
- **Author:** [Your Name]
- **Email:** [Your Email]
- **GitHub:** [Your GitHub Profile]
