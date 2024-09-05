--
-- Name: Matthew Schlatter
-- Date: 2023-03-31
-- Queries to select desired data from FarMarT sales database
-- 
use mschlatt;
#1 Retrieves the main attributes of each person
select personCode,firstName,lastName from Person;

#2 Retrieves the major fields for every person including their address
select p.personCode,p.firstName,p.lastName,a.street,a.city,s.state,a.zip,c.country from Person p 
	join Address a on p.addressId = a.addressId
    join State s on a.stateId = s.stateId
    join Country c on s.countryId = s.countryId;
    -- left join Email e on p.personId = e.personId;

#3  Gets the email addresses of a specific person
select p.firstName,p.lastName,e.email from Person p 
	left join Email e on p.personId = e.personId
    where p.personId = 12;

#4 Changes the email address of a specific email record
update Email set email = 'rcaghy9@dailymail.com' where emailId = (select emailId from Email where email = 'rcaghy9@dailymail.co.uk');

#5 Removes a specific person record
delete from Email where personId = 5;
delete from Person where personId = 5;

#6 Gets all the items on a specific invoice record
select v.invoiceCode,i.itemCode,i.identifier,i.name,i.unit,i.unitPrice,i.hourlyRate,i.model from Invoice v 
	left join InvoiceItem ii on v.invoiceId = ii.invoiceId
	left join Item i on ii.itemId = i.itemId
    where v.invoiceId = 3;
    
#7 Get all the items purchased by a specific person
select p.firstName,p.lastName,i.name as itemsPurchased from Invoice v
	left join InvoiceItem ii on v.invoiceId = ii.invoiceId
	left join Item i on ii.itemId = i.itemId
    left join Person p on v.customerId = p.personId
    where v.invoiceId = 3 and p.personCode = '6d4877';
    
#8 Finds the total number of sales made at each store
select s.storeCode,count(storeCode) as numberOfStoreSales from Invoice v 
	left join Store s on v.storeId = s.storeId group by v.storeId;

#9 Finds the total number of sales made by each employee
select p.firstName,p.lastName,count(v.salespersonId) as numberOfSalespersonSales from Invoice v
	join Person p on v.salespersonId = p.personId 
    group by v.salespersonId;

#10 Finds the subtotal charge of all products in each invoice
select ii.quantityOfProduct,i.unitPrice,ii.quantityOfProduct * i.unitPrice as productSubtotal from Invoice v
	join InvoiceItem ii on v.invoiceId = v.invoiceId
    join Item i on ii.itemId = i.itemId 
    group by i.itemCode having ii.quantityOfProduct * i.unitPrice > 0;

#11 Detects invalid data in invoice
select v.invoiceCode,count(i.itemCode) as numOfEachItem,i.itemCode from Invoice v 
	join InvoiceItem ii on v.invoiceId = ii.invoiceId
    join Item i on ii.itemId = i.itemId
    group by i.itemCode having numOfEachItem > 1;

#12 Detects a potential instance of fraud where an employee makes a sale to themselves
select * from Invoice v where v.customerId = v.salespersonId;