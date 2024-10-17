
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PayrollLibrary
{
    public class Payroll
    {
        /// <summary>
        /// Processes the employees of a given company by iterating through each department
        /// and printing the payment details of each employee whose Id is not null.
        /// </summary>
        /// <param name="company">The company whose employees are to be processed.</param>
        /// <returns>void</returns>
        public void ProcessEmployees(Company company)
        {
            foreach (var department in company.Departments)
            {
                foreach (var employee in department.Employees)
                {

                    // print the employee payment only if the employee Id is not null
                    if (employee.Id != null)
                    {
                        Console.WriteLine($"Employee Id: {employee.Id}, Payment: {employee.Payment}");
                    }
                    

                    
                }
            }
        }
    }
}
