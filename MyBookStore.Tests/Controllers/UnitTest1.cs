using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MyBookStore;
using MyBookStore.Controllers;

namespace MyBookStore.Tests.Controllers
{
    [TestClass]
    public class StoreControllerTest
    {
        [TestMethod]
        public void IndexViewResultNotNull()
        {
            HomeController controller = new HomeController();

            ViewResult result = controller.ToTest() as ViewResult;

            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void IndexViewEqualIndexCshtml()
        {
            HomeController controller = new HomeController();

            ViewResult result = controller.ToTest() as ViewResult;

            Assert.AreEqual("ToTest", result.ViewName);
        }

        [TestMethod]
        public void IndexStringInViewbag()
        {
            HomeController controller = new HomeController();

            ViewResult result = controller.ToTest() as ViewResult;

            Assert.AreEqual("Hello world!", result.ViewBag.Message);
        }
    }
}
