Point(1) = {0, 0, 0, 0.1};
Point(2) = {10, 0, 0, 0.1};
Point(3) = {10, 5, 0, 0.1};
Point(4) = {0, 5, 0, 0.1};
Point(5) = {0, 2.51, 0, 0.1};
Point(6) = {0, 2.49, 0, 0.1};
Point(7) = {2.5, 2.5, 0, 0.1};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 7};
Line(6) = {7, 6};
Line(7) = {6, 1};
Line Loop(9) = {3, 4, 5, 6, 7, 1, 2};
Plane Surface(9) = {9};
Physical Point(500) = {7};
Physical Line(20) = {1, 2, 3, 4, 7};
Physical Line(30) = {5, 6};
Physical Surface(1) = {9};
