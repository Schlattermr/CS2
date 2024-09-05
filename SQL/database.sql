--
-- Name: Matthew Schlatter
-- Date: 2023-03-31
-- Database to model sales subsystem for FarMarT
-- 
drop table if exists InvoiceItem;
drop table if exists Invoice;
drop table if exists Item;
drop table if exists Store;
drop table if exists Email;
drop table if exists Person;
drop table if exists Address;
drop table if exists State;
drop table if exists Country;

create table Country (
	countryId int not null primary key auto_increment,
    country varchar(50) not null
);

create table State (
	stateId int not null primary key auto_increment,
    state varchar(50),
    countryId int not null,
    foreign key (countryId) references Country(countryId)
);

create table Address (
	addressId int not null primary key auto_increment,
    street varchar(255) not null,
    city varchar(255) not null,
	zip varchar(255) not null,
    stateId int not null,
    foreign key (stateId) references State(stateId)
);

create table Person (
	personId int not null primary key auto_increment,
    personCode varchar(255) not null unique,
    firstName varchar(255) not null,
    lastName varchar(255) not null,
    addressId int not null,
    foreign key (addressId) references Address(addressId)
);

create table Email (
	emailId int not null primary key auto_increment,
    email varchar(255) not null unique,
    personId int not null,
    foreign key (personId) references Person(personId)
);

create table Store (
	storeId int not null primary key auto_increment,
    storeCode varchar(255) not null unique,
    managerId int not null,
    addressId int not null,
    foreign key (managerId) references Person(personId),
    foreign key (addressId) references Address(addressId)
);

create table Item (
	itemId int not null primary key auto_increment,
    itemCode varchar(255) not null unique,
    identifier varchar(1) not null,
    name varchar(255) not null,
    unit varchar(255),
    unitPrice double,
    hourlyRate double,
    model varchar(255)
);

create table Invoice (
	invoiceId int not null primary key auto_increment,
    invoiceCode varchar(255) not null unique,
    date varchar(50) not null,
    storeId int not null,
    customerId int not null,
    salespersonId int not null,
    foreign key (storeId) references Store(storeId),
    foreign key (customerId) references Person(personId),
    foreign key (salespersonId) references Person(personId),
    constraint unique (customerId,salespersonId)
);

create table InvoiceItem (
	invoiceItemId int not null primary key auto_increment,
    invoiceId int not null,
    itemId int not null,
    identifier varchar(1),
    leasePrice double,
    startDate varchar(50),
    endDate varchar(50),
    purchasePrice double,
    quantityOfProduct int,
    serviceLength double,
    foreign key (invoiceId) references Invoice(invoiceId),
    foreign key (itemId) references Item(itemId),
    constraint unique (invoiceId,itemId)
);
    
insert into Country (country) values ('US');

insert into State (state, countryId) values ('NY', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('CA', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('OH', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('IL', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('TX', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('LA', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('WA', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('PA', (select countryId from Country where country = 'US'));
insert into State (state, countryId) values ('ND', (select countryId from Country where country = 'US'));

insert into Address (street, city, stateId, zip) 
	values ('95 Moland Avenue', 'Buffalo', (select stateId from State where state = 'NY'), '64117');
insert into Address (street, city, stateId, zip) 
	values ('3 Spaight Lane', 'Sacramento', (select stateId from State where state = 'CA'), '24909');
insert into Address (street, city, stateId, zip) 
	values ('26 Continental Parkway', 'Cincinnati', (select stateId from State where state = 'OH'), '49349');
insert into Address (street, city, stateId, zip) 
	values ('30103 Stang Point', 'Chicago', (select stateId from State where state = 'IL'), '69196');
insert into Address (street, city, stateId, zip) 
	values ('5 Mcguire Parkway', 'Utica', (select stateId from State where state = 'NY'), '20615');
insert into Address (street, city, stateId, zip) 
	values ('3 Vera Crossing', 'El Paso', (select stateId from State where state = 'TX'), '52584');
insert into Address (street, city, stateId, zip) 
	values ('1 Moulton Avenue', 'Houston', (select stateId from State where state = 'TX'), '68180');
insert into Address (street, city, stateId, zip) 
	values ('95 Donald Lane', 'Youngstown', (select stateId from State where state = 'OH'), '17312');
insert into Address (street, city, stateId, zip) 
	values ('48 Blue Bill Park Pass', 'San Antonio', (select stateId from State where state = 'TX'), '67544');
insert into Address (street, city, stateId, zip) 
	values ('13 Northland Court', 'Los Angeles', (select stateId from State where state = 'CA'), '20713');
insert into Address (street, city, stateId, zip) 
	values ('66 Summerview Parkway', 'Monroe', (select stateId from State where state = 'LA'), '49349');
insert into Address (street, city, stateId, zip) 
	values ('39 Manley Point', 'Amarillo', (select stateId from State where state = 'TX'), '52124');
insert into Address (street, city, stateId, zip) 
	values ('06 Debra Point', 'Spokane', (select stateId from State where state = 'WA'), '52533');
insert into Address (street, city, stateId, zip) 
	values ('28 Vidon Crossing', 'Philadelphia', (select stateId from State where state = 'PA'), '68983');
insert into Address (street, city, stateId, zip) 
	values ('3293 Mockingbird Alley', 'San Antonio', (select stateId from State where state = 'TX'), '61703');
insert into Address (street, city, stateId, zip) 
	values ('122 Kropf Center', 'Fargo', (select stateId from State where state = 'ND'), '64064');
insert into Address (street, city, stateId, zip) 
	values ('088 Monterey Way', 'Los Angeles', (select stateId from State where state = 'CA'), '20713');
insert into Address (street, city, stateId, zip) 
	values ('78116 Saint Paul Road', 'Amarillo', (select stateId from State where state = 'TX'), '52124');
insert into Address (street, city, stateId, zip) 
	values ('60 Del Sol Court', 'Youngstown', (select stateId from State where state = 'OH'), '17312');
insert into Address (street, city, stateId, zip) 
	values ('089 Mariners Cove Avenue', 'Philadelphia', (select stateId from State where state = 'PA'), '68983');
insert into Address (street, city, stateId, zip) 
	values ('8 Northview Road', 'San Antonio',(select stateId from State where state = 'TX'), '61703');

insert into Person (personCode, lastName, firstName, addressId) 
	values ('296071', 'Garvin', 'Gearalt', (select addressId from Address where street = '95 Moland Avenue'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('15e71b', 'Grombridge', 'Selby', (select addressId from Address where street = '3 Spaight Lane'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('6d4877', 'Antowski', 'Rosabel', (select addressId from Address where street = '26 Continental Parkway'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('3879f2', 'Laity', 'Adara', (select addressId from Address where street = '30103 Stang Point'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('065f73', 'Baline', 'Evonne', (select addressId from Address where street = '5 Mcguire Parkway'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('5e354a', 'Selley', 'Errick', (select addressId from Address where street = '3 Vera Crossing'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('523ab3', 'Stower', 'Hersh', (select addressId from Address where street = '1 Moulton Avenue'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('2f3729', 'Noddles', 'Marina', (select addressId from Address where street = '95 Donald Lane'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('36f0bd', 'Wathan', 'Ker', (select addressId from Address where street = '48 Blue Bill Park Pass'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('1acf51', 'Branni', 'Evangeline', (select addressId from Address where street = '13 Northland Court'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('2a0c8f', 'Theseira', 'Roarke', (select addressId from Address where street = '66 Summerview Parkway'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('aebed4', 'Linzey', 'Tripp', (select addressId from Address where street = '39 Manley Point'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('332d99', 'Rottery', 'Gerri', (select addressId from Address where street = '06 Debra Point'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('af3d3d', 'Domingues', 'Audrie', (select addressId from Address where street = '28 Vidon Crossing'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('6e41d6', 'Elcox', 'Garrot', (select addressId from Address where street = '3293 Mockingbird Alley'));
insert into Person (personCode, lastName, firstName, addressId) 
	values ('a3d17b', 'Haylands', 'Hervey', (select addressId from Address where street = '122 Kropf Center'));

insert into Store (storeCode, managerId, addressId) 
	values ('332fca', (select personId from Person where personCode = '1acf51'), 
            (select addressId from Address where street = '088 Monterey Way'));
insert into Store (storeCode, managerId, addressId) 
	values ('bd3852', (select personId from Person where personCode = 'aebed4'), 
			(select addressId from Address where street = '78116 Saint Paul Road'));
insert into Store (storeCode, managerId, addressId) 
	values ('5be873', (select personId from Person where personCode = '2f3729'), 
			(select addressId from Address where street = '60 Del Sol Court'));
insert into Store (storeCode, managerId, addressId) 
	values ('349a93', (select personId from Person where personCode = 'af3d3d'), 
			(select addressId from Address where street = '089 Mariners Cove Avenue'));
insert into Store (storeCode, managerId, addressId) 
	values ('bfbf29', (select personId from Person where personCode = '6e41d6'), 
			(select addressId from Address where street = '8 Northview Road'));
    
insert into Email (email, personId) values ('sgrombridge1@spotify.com', (select personId from Person where personCode = '15e71b'));
insert into Email (email, personId) values ('nmelsom0@facebook.com', (select personId from Person where personCode = '15e71b'));
insert into Email (email, personId) values ('rantowski2@economist.com', (select personId from Person where personCode = '6d4877'));
insert into Email (email, personId) values ('kdunford1@cloudflare.com', (select personId from Person where personCode = '6d4877'));
insert into Email (email, personId) values ('ghanburybrown2@indiatimes.com', (select personId from Person where personCode = '6d4877'));
insert into Email (email, personId) values ('alaity3@examiner.com', (select personId from Person where personCode = '3879f2'));
insert into Email (email, personId) values ('ebaline4@ted.com', (select personId from Person where personCode = '065f73'));
insert into Email (email, personId) values ('eselley5@jugem.jp', (select personId from Person where personCode = '5e354a'));
insert into Email (email, personId) values ('dbehnecken3@woothemes.com', (select personId from Person where personCode = '5e354a'));
insert into Email (email, personId) values ('hstower6@ning.com', (select personId from Person where personCode = '523ab3'));
insert into Email (email, personId) values ('mnoddles0@dagondesign.com', (select personId from Person where personCode = '2f3729'));
insert into Email (email, personId) values ('rdcruze1@symantec.com', (select personId from Person where personCode = '2f3729'));
insert into Email (email, personId) values ('adjorvic2@bloomberg.com', (select personId from Person where personCode = '2f3729'));
insert into Email (email, personId) values ('kwathan1@fotki.com', (select personId from Person where personCode = '36f0bd'));
insert into Email (email, personId) values ('tlinzey3@msu.edu', (select personId from Person where personCode = 'aebed4'));
insert into Email (email, personId) values ('kfisby4@java.com', (select personId from Person where personCode = 'aebed4'));
insert into Email (email, personId) values ('grottery0@noaa.gov', (select personId from Person where personCode = '332d99'));
insert into Email (email, personId) values ('gelcox5@blog.com', (select personId from Person where personCode = '6e41d6'));
insert into Email (email, personId) values ('lcapoun0@cbc.ca', (select personId from Person where personCode = '6e41d6'));
insert into Email (email, personId) values ('hhaylandsf@vimeo.com', (select personId from Person where personCode = 'a3d17b'));
insert into Email (email, personId) values ('lcoward8@abc.net.au', (select personId from Person where personCode = 'a3d17b'));
insert into Email (email, personId) values ('rcaghy9@dailymail.co.uk', (select personId from Person where personCode = 'a3d17b'));
insert into Email (email, personId) values ('bbuller4@economist.com', (select personId from Person where personCode = 'a3d17b'));
    
insert into Item (itemCode, identifier, name, model) values ('h9h16m', 'E', 'Seeder', 'Planter 123HD');
insert into Item (itemCode, identifier, name, model) values ('faw901', 'E', 'Tractor', 'Big Tract 02');
insert into Item (itemCode, identifier, name, model) values ('10d2k5', 'E', 'Baler', 'Buy Me Please 500');
insert into Item (itemCode, identifier, name, model) values ('y82n48', 'E', 'Fertilizer Spreader', 'FS09');
insert into Item (itemCode, identifier, name, unit, unitPrice) values ('2ij9gn', 'P', 'Fertilizer', 'gallon', '15.50');
insert into Item (itemCode, identifier, name, unit, unitPrice) values ('329an3', 'P', 'Wheat Seed', 'bag', '25.0');
insert into Item (itemCode, identifier, name, unit, unitPrice) values ('02knsa', 'P', 'Rocks', 'ton', '1000.0');
insert into Item (itemCode, identifier, name, unit, unitPrice) values ('e420pl', 'P', 'Wooden Fence', '1ft', '14.0');
insert into Item (itemCode, identifier, name, hourlyRate) values ('al308v', 'S', 'Fencing', 150.0);
insert into Item (itemCode, identifier, name, hourlyRate)values ('9hi8ba', 'S', 'Therapy', 20.0);
insert into Item (itemCode, identifier, name, hourlyRate) values ('ma931n', 'S', 'Introduction to Farming', 30.0);
insert into Item (itemCode, identifier, name, hourlyRate) values ('2m1nal', 'S', 'Delivery', 50.0);

insert into Invoice (invoiceCode, storeId, customerId, salespersonId, date) 
	values ('INV001', (select storeId from Store where storeCode = '332fca'), 
			(select personId from Person where personCode = '15e71b'), 
            (select personId from Person where personCode = '36f0bd'), '2023-02-14');
insert into Invoice (invoiceCode, storeId, customerId, salespersonId, date) 
	values ('INV002', (select storeId from Store where storeCode = 'bd3852'), 
			(select personId from Person where personCode = '523ab3'), 
            (select personId from Person where personCode = '2a0c8f'), '2023-02-16');
insert into Invoice (invoiceCode, storeId, customerId, salespersonId, date) 
	values ('INV003', (select storeId from Store where storeCode = '349a93'), 
			(select personId from Person where personCode = '6d4877'), 
            (select personId from Person where personCode = '332d99'), '2023-02-19');
insert into Invoice (invoiceCode, storeId, customerId, salespersonId, date) 
	values ('INV004', (select storeId from Store where storeCode = '349a93'), 
			(select personId from Person where personCode = '296071'), 
            (select personId from Person where personCode = '332d99'), '2023-02-24');
insert into Invoice (invoiceCode, storeId, customerId, salespersonId, date) 
	values ('INV005', (select storeId from Store where storeCode = 'bfbf29'), 
			(select personId from Person where personCode = '5e354a'), 
            (select personId from Person where personCode = 'a3d17b'), '2023-03-02');

insert into InvoiceItem (invoiceId, itemId, serviceLength) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV001'), 
			(select itemId from Item where itemCode = '9hi8ba'), 20.0);
insert into InvoiceItem (invoiceId, itemId, identifier, leasePrice, startDate, endDate) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV003'), 
			(select itemId from Item where itemCode = 'y82n48'), 
            'L', '5000.0', '2023-03-01', '2023-03-30');
insert into InvoiceItem (invoiceId, itemId, quantityOfProduct) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV005'), 
			(select itemId from Item where itemCode = 'e420pl'), 100);
insert into InvoiceItem (invoiceId, itemId, serviceLength) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV001'), 
			(select itemId from Item where itemCode = 'ma931n'), 10.0);
insert into InvoiceItem (invoiceId, itemId, identifier, purchasePrice) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV002'), 
			(select itemId from Item where itemCode = 'faw901'), 'P', '100000.0');
insert into InvoiceItem (invoiceId, itemId, quantityOfProduct) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV003'), 
			(select itemId from Item where itemCode = '2ij9gn'), 7);
insert into InvoiceItem (invoiceId, itemId, quantityOfProduct) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV002'), 
			(select itemId from Item where itemCode = '02knsa'), 2);
insert into InvoiceItem (invoiceId, itemId, serviceLength) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV005'), 
			(select itemId from Item where itemCode = 'al308v'), 4.5);
insert into InvoiceItem (invoiceId, itemId, quantityOfProduct) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV004'), 
			(select itemId from Item where itemCode = '329an3'), 5);
insert into InvoiceItem (invoiceId, itemId, identifier, leasePrice, startDate, endDate) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV001'), 
			(select itemId from Item where itemCode = '10d2k5'), 
            'L', '10000.0', '2023-03-01', '2023-04-29');
insert into InvoiceItem (invoiceId, itemId, serviceLength) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV003'), 
			(select itemId from Item where itemCode = '2m1nal'), 1.0);
insert into InvoiceItem (invoiceId, itemId, identifier, purchasePrice) 
	values ((select invoiceId from Invoice where invoiceCode = 'INV004'), 
			(select itemId from Item where itemCode = 'h9h16m'), 'P', 10000.0);