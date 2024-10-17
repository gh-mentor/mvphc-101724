using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.IO;

namespace PayrollLibrary
{
    [TestClass]
    public class PayrollTest
    {
        [TestMethod]
        public void TestProcessEmployees()
        {
            // Arrange
            var payroll = new Payroll();
            var company = new Company
            {
                Departments = new List<Department>
                {
                    new Department
                    {
                        Employees = new List<Employee>
                        {
                            new Employee { Id = "1", Payment = 1000 },
                            new Employee { Id = "2", Payment = 1500 },
                            new Employee { Id = null, Payment = 2000 }
                        }
                    }
                }
            };

            using (var sw = new StringWriter())
            {
                Console.SetOut(sw);

                // Act
                payroll.ProcessEmployees(company);

                // Assert
                var expectedOutput = "Employee Id: 1, Payment: 1000\r\nEmployee Id: 2, Payment: 1500\r\n";
                Assert.AreEqual(expectedOutput, sw.ToString());
            }
        }
    }

    // Mock classes for testing
    public class Company
    {
        public List<Department> Departments { get; set; }
    }

    public class Department
    {
        public List<Employee> Employees { get; set; }
    }

    public class Employee
    {
        public string Id { get; set; }
        public decimal Payment { get; set; }
    }
}