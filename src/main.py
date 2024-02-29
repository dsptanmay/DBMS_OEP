"""
Authors: Tanmay Deshpande, Sriniwas Paste, Abhishek Kalgudi
Title: Database Management Systems - Open Ended Project
Flight Booking System
"""

from datetime import datetime
import os
from turtle import st
import pymysql.cursors
import questionary as qr
import pprint
from tabulate import tabulate


class App:
    def __init__(self):
        self.cnx = pymysql.connect(
            host="localhost",
            user="1SI21CS110",
            password="root",
            database="oep",
            cursorclass=pymysql.cursors.DictCursor,
        )

        self.cursor = self.cnx.cursor()

    def showAllPassengers(self):
        getQuery = "SELECT * FROM `passengers`"
        self.cursor.execute(getQuery)
        res = self.cursor.fetchall()
        vals = []
        for row in res:
            vals.append(list(map(str, row.values())))

        print(
            tabulate(
                vals,
                headers=[
                    "Passenger ID",
                    "First Name",
                    "Last Name",
                    "Email ID",
                    "Phone Number",
                ],
                tablefmt="fancy_grid",
            )
        )

    def showAllBookings(self):
        """Show all Bookings done by a particular passenger according to `passenger-id`.

        Calls the procedure `displayBookings` which is already stored in the database
        """

        pid = qr.text("Enter pid of user").ask()
        showQuery = "call displayBookings(%s)"
        self.cursor.execute(
            showQuery,
            (int(pid),),
        )
        data = self.cursor.fetchall()
        if len(data) == 0:
            print("No bookings found for particular user!")
            return

        for entry in data:
            entry["bookingDate"] = entry["bookingDate"].strftime("%Y-%m-%d")
            entry["deptDateTime"] = entry["deptDateTime"].strftime("%Y-%m-%d %H:%M:%S")
            entry["arrDateTime"] = entry["arrDateTime"].strftime("%Y-%m-%d %H:%M:%S")

        keys_order = [
            "bID",
            "pID",
            "fID",
            "seatNo",
            "bookingDate",
            "flightNo",
            "deptArpId",
            "arrArpId",
            "deptDateTime",
            "arrDateTime",
        ]

        res = [[row[key] for key in keys_order] for row in data]
        headers = [
            "Booking ID",
            "Passenger ID",
            "Flight ID",
            "Seat Number",
            "Booking Date",
            "Flight Number",
            "Departure ArpID",
            "Arrival ArpID",
            "Departure Time",
            "Arrival Time",
        ]
        print(tabulate(res, headers=headers, tablefmt="fancy_grid"))

    def bookingsPsgrPrevYear(self):
        self.cursor.execute("SELECT pid from `passengers`")
        res = self.cursor.fetchall()
        vals = [str(row["pid"]) for row in res]

        pid = qr.autocomplete("Choose a Passenger ID ", choices=vals).ask()
        bQuery = "call bookingsPrevYear(%s)"
        self.cursor.execute(
            bQuery,
            (int(pid),),
        )
        data = self.cursor.fetchone()
        term = os.get_terminal_size()
        print(
            "Number of Bookings done by passenger in previous year".center(
                term.columns, " "
            )
        )
        print("-" * term.columns)

        print(
            str(data.get("avg_bookings", None)).center(term.columns, " "),
        )

    def showAvgBookingsRange(self):
        start_date = qr.text("Enter start date", instruction="(YYYY-MM-DD)").ask()
        end_date = qr.text("Enter end date", instruction="(YYYY-MM-DD)").ask()

        start_date = datetime.strptime(
            start_date,
            "%Y-%m-%d",
        )
        end_date = datetime.strptime(
            end_date,
            "%Y-%m-%d",
        )
        if start_date > end_date:
            qr.print(
                "End Date cannot be less than start date!",
                style="bold italic fg:red",
            )

        procQuery = "call avgBookingsPerDay(%s, %s)"
        self.cursor.execute(
            procQuery,
            (
                start_date,
                end_date,
            ),
        )
        res = self.cursor.fetchone()
        term = os.get_terminal_size().columns
        print("Average Number of Bookings Done Per Day".center(term, " "))
        print("-" * term)
        print(str(res.get("averageBookingsPerDay")).center(term, " "))

    def updateContactDetails(self):
        self.cursor.execute("SELECT pid FROM `passengers`")
        res = self.cursor.fetchall()
        vals = []
        for row in res:
            vals.append(str(row["pid"]))
        # print(vals)
        pid = qr.autocomplete("Choose a Passenger ID to modify", choices=vals).ask()
        email = qr.text(
            "Enter the new email id", instruction="(Leave blank for no changes)"
        ).ask()
        phone = qr.text(
            "Enter the new phone no", instruction="(Leave blank for no changes)"
        ).ask()
        if len(email) == 0 and len(phone) == 0:
            print("No modifications done to the email and phone number!")
            return
        if len(email) != 0:
            emailQuery = "UPDATE `passengers` SET email=%s WHERE pid=%s"
            self.cursor.execute(
                emailQuery,
                (
                    email,
                    int(pid),
                ),
            )
            self.cnx.commit()
            qr.print("Email ID successfully modified!", style="bold italic fg:green")

        if len(phone) != 0:
            phoneQuery = "UPDATE `passengers` SET phone=%s WHERE pid=%s"
            self.cursor.execute(
                phoneQuery,
                (
                    phone,
                    int(pid),
                ),
            )
            self.cnx.commit()
            qr.print(
                "Phone Number successfully modified!", style="bold italic fg:green"
            )

    def insertData(self):
        pid = qr.text("Enter the Passenger ID").ask()
        firstName = qr.text("Enter First Name").ask()
        lastName = qr.text("Enter Last Name").ask()
        emailContact = qr.text("Enter Email ID").ask()
        phoneContact = qr.text("Enter Phone Number").ask()

        insertQuery = """INSERT INTO `passengers`
                        (`pid`, `firstName`, `lastName`, `email`, `phone`) 
                        VALUES(%s, %s, %s, %s, %s)"""
        self.cursor.execute(
            insertQuery,
            (
                int(pid),
                firstName,
                lastName,
                emailContact,
                phoneContact,
            ),
        )
        self.cnx.commit()


class Main(App):
    def __init__(self):
        super().__init__()

    def askQueries(self):
        chs = [
            "Show All Passengers",
            "Update contact details for a particular passenger",
            "BACK",
            "EXIT",
        ]
        ch = qr.select(
            "Choose a query to you want to perform",
            choices=chs,
            default=chs[0],
        ).ask()
        if ch == chs[-2]:
            self.mainMenu()
        elif ch == chs[-1]:
            exit(1)
        elif ch == chs[0]:
            self.showAllPassengers()
        elif ch == chs[1]:
            self.updateContactDetails()

    def askProcedures(self):
        chs = [
            "Show All Bookings for a particular passenger",
            "Display number of bookings done by a passenger in the previous year",
            "Display avg no of bookings done per day in a given date range",
            "BACK",
            "EXIT",
        ]
        while True:
            ch = qr.select(
                "Choose a query to you want to perform",
                choices=chs,
                default=chs[0],
            ).ask()
            if ch == chs[-1]:
                exit(1)
            elif ch == chs[-2]:
                self.mainMenu()
            elif ch == chs[0]:
                self.showAllBookings()
            elif ch == chs[1]:
                self.bookingsPsgrPrevYear()
            elif ch == chs[2]:
                self.showAvgBookingsRange()

    def mainMenu(self):
        chs = ["Stored Queries", "Stored Procedures", "EXIT"]
        while True:
            ch = qr.select(
                "Choose the action set you want to use",
                choices=chs,
                default=chs[0],
            ).ask()
            if ch == chs[-1]:
                exit(1)
            elif ch == chs[0]:
                self.askQueries()
            else:
                self.askProcedures()


if __name__ == "__main__":
    ob = Main()
    ob.mainMenu()
