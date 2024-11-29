function EnhancedTicketBookingSystem243
    fig = uifigure('Name', 'Ticket Booking System', 'Position', [100, 100, 800, 600]);
    uilabel(fig, 'Text', 'Ticket Booking System', ...
        'FontSize', 22, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'Position', [200, 550, 400, 40]);
    bookingPanel = uipanel(fig, 'Title', 'Booking Details', ...
        'FontSize', 14, 'Position', [20, 300, 360, 220]);
    uilabel(bookingPanel, 'Text', 'Name:', 'Position', [10, 160, 100, 22]);
    nameField = uieditfield(bookingPanel, 'text', 'Position', [120, 160, 200, 22]);
    uilabel(bookingPanel, 'Text', 'Contact Number:', 'Position', [10, 120, 100, 22]);
    contactField = uieditfield(bookingPanel, 'numeric', 'Position', [120, 120, 200, 22]);
    uilabel(bookingPanel, 'Text', 'Transport Mode:', 'Position', [10, 80, 100, 22]);
    modeDropDown = uidropdown(bookingPanel, 'Items', {'Flights', 'Trains', 'Buses'}, ...
        'Position', [120, 80, 200, 22], 'ValueChangedFcn', @(src, event) updateModeFields());
     uilabel(bookingPanel, 'Text', 'Class/Type:', 'Position', [10, 40, 100, 22]);
    specificFieldInput = uieditfield(bookingPanel, 'text', 'Position', [120, 40, 200, 22]);
    seatLabel = uilabel(bookingPanel, 'Text', 'Available Seats:', 'Position', [10, 10, 100, 22]);
    seatDisplay = uilabel(bookingPanel, 'Text', '', 'Position', [120, 10, 100, 22])
    priceLabel = uilabel(fig, 'Text', 'Price: ₹', 'FontWeight', 'bold', ...
        'Position', [420, 480, 70, 22]);
    priceDisplay = uilabel(fig, 'Text', '0.00', ...
        'Position', [490, 480, 100, 22]);
    bookButton = uibutton(fig, 'Text', 'Book Ticket', ...
        'Position', [500, 430, 120, 40], ...
        'ButtonPushedFcn', @(btn, event) bookTicket());
    tablePanel = uipanel(fig, 'Title', 'Current Bookings', ...
        'FontSize', 14, 'Position', [20, 20, 760, 260]);
    bookingTable = uitable(tablePanel, 'Position', [10, 10, 740, 200], ...
        'ColumnName', {'Name', 'Contact', 'Mode', 'Details', 'Price'}, ...
        'Data', {}, ...
        'CellSelectionCallback', @(src, event) selectBooking(event));    saveButton = uibutton(fig, 'Text', 'Save Data', ...
        'Position', [400, 20, 80, 30], ...
        'ButtonPushedFcn', @(btn, event) saveData());
    loadButton = uibutton(fig, 'Text', 'Load Data', ...
        'Position', [500, 20, 80, 30], ...
        'ButtonPushedFcn', @(btn, event) loadData());
    cancelButton = uibutton(fig, 'Text', 'Cancel Booking', ...
        'Position', [600, 20, 120, 30], ...
        'ButtonPushedFcn', @(btn, event) cancelBooking());
    rng(0,'twister');
    r = randi([0 10].*9);
    s = randi([0 10].*9);
    t = randi([0 10].*9);
    seatData = struct('Flights', r, 'Trains', s, 'Buses', t);
    selectedRow = []; % Store selected row index
    updateSeats();
    function updateModeFields()
        mode = modeDropDown.Value;
        updateSeats();
    end
    function updateSeats()
        mode = modeDropDown.Value;
        seatDisplay.Text = num2str(seatData.(mode));
    end
    function bookTicket()
        mode = modeDropDown.Value;
        name = nameField.Value;
        contact = contactField.Value;
        details = specificFieldInput.Value;
        price = calculatePrice(mode, details);
        if isempty(name) || isempty(contact) || isempty(details)
            uialert(fig, 'Please fill all fields.', 'Error');
            return;
        end
        if seatData.(mode) <= 0
            uialert(fig, 'No seats available!', 'Error');
            return;
        end
        newRow = {name, contact, mode, details, sprintf('₹%.2f', price)};
        bookingTable.Data = [bookingTable.Data; newRow];
        seatData.(mode) = seatData.(mode) - 1;
        updateSeats();
    end
    function cancelBooking()
        if isempty(selectedRow)
            uialert(fig, 'Please select a booking to cancel.', 'Error');
            return;
        end
        data = bookingTable.Data;
        mode = data{selectedRow, 3}; % Transport mode
        seatData.(mode) = seatData.(mode) + 1; % Increment available seats
        data(selectedRow, :) = [];
        bookingTable.Data = data;
        selectedRow = []; % Reset selection
        updateSeats();
        uialert(fig,'Your booking has been canceled');
    end
    function saveData()
        data = bookingTable.Data;
        if isempty(data)
            uialert(fig, 'No data to save.', 'Error');
            return;
        end
        writetable(cell2table(data, 'VariableNames', bookingTable.ColumnName), 'Bookings.csv');
        uialert(fig, 'Data saved to Bookings.csv!', 'Success');
    end
    function loadData()
        if isfile('Bookings.csv')
            data = table2cell(readtable('Bookings.csv'));
            bookingTable.Data = data;
        else
            uialert(fig, 'No saved data found.', 'Error');
        end
    end
    function selectBooking(event)
        if isempty(event.Indices)
            selectedRow = [];
        else
            selectedRow = event.Indices(1);
        end
    end
    function price = calculatePrice(mode, details)
        switch mode
            case 'Flights'
                price = 2500;
                if strcmpi(details, 'Business')
                    price = price * 2;
                end
            case 'Trains'
                price = 750;
                if strcmpi(details, 'AC')
                    price = price * 1.5;
                end
            case 'Buses'
                price = 500;
                if strcmpi(details, 'Recliner')
                    price = price * 1.2;
                end
            otherwise
                price = 0;
        end
        priceDisplay.Text = sprintf('%.2f', price);
    end
end