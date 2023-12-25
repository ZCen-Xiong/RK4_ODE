##fixed-step version fo 4th order Runge-kutta
 #Numerical solution of a system of differential equations (including event functions) using the fourth-order Runge-Kutta method
*Input parameters:*
*odefunc*: Function handle for the system of differential equations, in the form f(t, y), where t is the current time and y is the current state vector
 *tspan:* Vector containing the start and end times, in the form [t0, tn]
 *y0: *Initial values of the state vector at time t0 (row vector)
 *h: *Time step
*events:* Function handle for the event functions, in the form events(t, y)

 *Output parameters:*
 *t:*Vector of time points for the numerical solution
 *y:* Matrix of numerical solution, where each row contains the solution of the state vector at the corresponding time point
 *te:*Time at which the event occurred
 *ye:*Solution of the event at the event time
 *ie:* Index of the triggered event function