$(function () {
    // *********************************************************************
    // Feel free to modify/remove the JS objects below.
    // *********************************************************************

    const customers = [
        {
            "name": "Alice Johnson",
            "email": "alice@example.com",
            "status": "Active",
            "joined": "09/10/2026"
        },
        {
            "name": "Robert Smith",
            "email": "robert@example.com",
            "status": "Pending",
            "joined": "09/12/2026"
        },
        {
            "name": "Maria Garcia",
            "email": "maria@example.com",
            "status": "Active",
            "joined": "09/15/2026"
        }
    ];

    const sales = [
        {
            "product": "Product A",
            "quantity": "124",
            "revenue": "$12,400"
        },
        {
            "product": "Product B",
            "quantity": "98",
            "revenue": "$9,800"
        },
        {
            "product": "Product C",
            "quantity": "75",
            "revenue": "$7,500"
        },
    ];

    const activities = [
        {
            "message" : "New customer registered"
        },
        {
            "message" : "Order #10482 completed"
        },
        {
            "message" : "Payment received"
        },
        {
            "message" : "Support ticket created"
        }
    ];

    const messages = [
        {
            "messsage" : "All systems operational"
        },
        {
            "messsage" : "All settings loaded for this system"
        }
    ];

    const notifications = [
        {
            "messsage": "A new shipment is expected to arrive on Sep 30, 2026"
        },
        {
            "messsage": "There are 12 outstanding issues with last week's orders"
        },
        {
            "messsage": "Three new customers joined our platform in the last month"
        },
    ];

    const tasks = [
       {
            "messsage": "Review orders"
        },
        {
            "messsage": "Contact customer"
        },
        {
            "messsage": "Generate report"
        },
    ]

    // There are 13 requirements to implement. 
    const userNameObj = $("#username");
    userNameObj.append(`${username}`);

    const notificationNumber = $("#notification-num");
    notificationNumber.append(`${notifAmt}`);

    const tableBody = $("#customerTableBody");

    customers.forEach(customer => {
        const row = $("<tr>");

        var statusClass;
            if (customer.status.toLowerCase() === "active"){
                statusClass = "status-active";
            } else {
                statusClass = "status-pending";
            }
        row.html(`
            <td>${customer.name}</td>
            <td>${customer.email}</td>
            <td>
                <span class="status ${statusClass}">
                    ${customer.status}
                </span>
            </td>
            <td>${customer.joined}</td>
        `);

        tableBody.append(row);
    });

   
    const salesTableBody = $("#salesTableBody");

    sales.forEach(sale => {
        const row = $("<tr>");

        row.html(`
            <td>${sale.product}</td>
            <td>${sale.quantity}</td>
            <td>${sale.revenue}</td>
        `);

        salesTableBody.append(row);
    });

    const activityList = $("#activity-list");

    activities.forEach(activity => {
        const li = $("<li>");
        li.html(`${activity.message}`);
        activityList.append(li);
    });

 
    const systemStatusList = $("#system-status-list");

    messages.forEach(msg => {
        const li = $("<li>");
        li.html(`${msg.messsage}`);
        systemStatusList.append(li);
    });


    const notificationsList = $("#notifications-list");

    notifications.forEach(notif => {
        const li = $("<li>");
        li.html(`${notif.messsage}`);
        notificationsList.append(li);
    });


    const tasksList = $("#tasks-list");

    tasks.forEach(task => {
        const li = $("<li>");
        li.html(`${task.messsage}`);
        tasksList.append(li);
    });


    // All six jQuery UI functions

    $("button").button();
       
    $("#dashboardTabs").tabs();

    $("#customerDate").datepicker();

    $("#accordion").accordion({
        collapsible: true,
        heightStyle: "content"
    });

    $("#customerDialog").dialog({
        autoOpen: false,
        modal: true,
        width: 450,
        buttons: {
            "Create Customer": function () {
                var name = $("#customerName").val();
                var email = $("#customerEmail").val();
                if (!name || !email) {
                    alert(
                        "Please enter a name and email."
                    );
                    return;
                }

                alert("Customer created: " + name);
                $(this).dialog("close");
            },
            "Cancel": function () {
                $(this).dialog("close");
            }
        }

    });


    $("#newCustomerButton").on(
        "click",
        function () {
            $("#customerDialog").dialog("open");
        }
    );



       


    });
