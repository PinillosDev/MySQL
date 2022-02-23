USE DBwarehouse;

-- Show all warehouses
SELECT * FROM warehouses;

-- Show boxes who price > 450
SELECT * FROM boxes
WHERE box_value > 450;

-- Show distinct types of boxes
SELECT DISTINCT content FROM boxes;

-- Show average of the price of all boxes
SELECT AVG(box_value) AS average_price FROM boxes;

-- Show average of the box price / warehouses
SELECT warehouse, AVG(box_value) AS average_price
FROM boxes
GROUP BY warehouse;

-- Show id of warehouses if the boxes' average > 500
SELECT warehouse FROM boxes
GROUP BY warehouse
HAVING AVG(box_value) > 500;

-- Show box id and city where it is
SELECT b.box_id, w.country FROM boxes AS b
INNER JOIN warehouses AS w
ON w.warehouse_id=b.warehouse;

-- Show number of boxes / warehouse
SELECT warehouse, COUNT(box_id) AS boxes
FROM boxes
GROUP BY warehouse;

-- Show if a warehouse has an overflow
SELECT DISTINCT w.warehouse_id FROM warehouses AS w
INNER JOIN boxes AS b
WHERE b.content < w.capacity;

-- Show id of boxes who are in Perú
SELECT b.box_id FROM boxes AS b
INNER JOIN warehouses AS w
ON w.warehouse_id=b.warehouse
WHERE w.country="Perú";

-- Insert some data
INSERT INTO warehouses (country, capacity)
VALUES ('España', 3);

INSERT INTO boxes (box_id, content, box_value, warehouse)
VALUES ('H5RT1', 30, 200, 2);

-- Apply -15% to all value boxes
UPDATE boxes SET box_value = box_value*0.85;

-- Apply -20% to boxes who has a value higher tan the avg
UPDATE boxes SET box_value = box_value * 0.80
WHERE box_value > (
	SELECT d.box_value FROM (SELECT AVG(box_value) AS box_value FROM boxes) AS d
);

-- Delete boxes who value < 50
DELETE FROM boxes
WHERE box_value < 50;

-- Clean warehouses who capacity is overflow
DELETE FROM boxes AS b
WHERE b.warehouse = (
	SELECT w.warehouse_id FROM(
		SELECT warehouse, SUM(content) AS number_boxes FROM boxes GROUP BY warehouse
    ) AS ayuda
	INNER JOIN warehouses AS w
	ON w.warehouse_id=ayuda.warehouse
    WHERE w.capacity < ayuda.number_boxes
);