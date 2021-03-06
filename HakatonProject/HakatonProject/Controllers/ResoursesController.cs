﻿using HakatonProject.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;

namespace HakatonProject.Controllers
{
    public class ResoursesController : Controller
    {
        private Hakaton_projectEntities db = new Hakaton_projectEntities();

        public ActionResult Search()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Search(string InputName, string InputGenre)
        {

            ViewBag.InputName = InputName;
            ViewBag.InputGenre = InputGenre;
            if (string.IsNullOrEmpty(InputName) && string.IsNullOrEmpty(InputGenre))
            {
                return View();
            }
            if (!string.IsNullOrEmpty(InputName) && string.IsNullOrEmpty(InputGenre))
            {
                return View(db.Resourses.Where(o => o.Name.Contains(InputName) || o.Name == InputName));
            }
            if (string.IsNullOrEmpty(InputName) && !string.IsNullOrEmpty(InputGenre))
            {
                return View(db.Resourses.Where(o => o.Genre.Contains(InputGenre) || o.Genre == InputGenre));
            }
            if (string.IsNullOrEmpty(InputName) && string.IsNullOrEmpty(InputGenre))
            {
                return View(db.Resourses.Where(o => (o.Name.Contains(InputName) || o.Name == InputName) && (o.Genre.Contains(InputGenre) || o.Genre == InputGenre)));
            }
            return View();
        }

        public ActionResult Location(int? id)
        {
            if (id == null || id == 0)
            {
                RedirectToAction("Search");
            }
           
            string typeres = db.Resourses.Where(o => o.ID == id).Select(o => o.ResourseTypes.Type_name).First().ToString(); //тип ресурса
            //var resloc2 = db.Resourses.Where(o => o.ID == id).Select(o => o.location.ToString()).ToString();
            int resloc = Convert.ToInt32(db.Resourses.Where(o => o.ID == id).Select(o => o.location).First().ToString()); //ID локации (ресурслокатион)
            int buildid = Convert.ToInt32(db.ResourseLocation.Where(o => o.ID == resloc).Select(o => o.building).First().ToString()); //ID здания

            string build = db.buildings.Where(o => o.ID == buildid).Select(o => o.Name).First().ToString();

            string floor = db.ResourseLocation.Where(o => o.ID == resloc).Select(o => o.floor).First().ToString();

            int typeid = Convert.ToInt32(db.ResourseLocation.Where(o => o.ID == resloc).Select(o => o.locationType).First().ToString()); //ID типа локации

            string typeloc = db.LocType.Where(o => o.id == typeid).Select(o => o.type).First().ToString();

            string locname = db.ResourseLocation.Where(o => o.ID == resloc).Select(o => o.name).First().ToString();

            string SectionName = db.Resourses.Where(o => o.ID == id).Select(o => o.Section).First().ToString();

            string shelfname = db.Resourses.Where(o => o.ID == id).Select(o => o.shelf).First().ToString();

            ViewBag.Location = typeres + " находится в здании " + build + " на " + floor + " этаже в " + typeloc + " " + locname + " в Секции " + SectionName+ " на " + shelfname + " полке"+ " . Следуйте по меткам, чтобы не заблудится ";
            ViewBag.Locname = locname;
            ViewBag.Section = SectionName;
            return View();
        }

        public ActionResult LocationAuditore(int? id)
        {
            if (id == null || id == 0)
            {
                RedirectToAction("Search");
            }

            string typeauditore = db.ResourseLocation.Where(o => o.ID == id).Select(o => o.LocType.type).First().ToString(); //тип аудитории
            //var resloc2 = db.Resourses.Where(o => o.ID == id).Select(o => o.location.ToString()).ToString();
            string auditoreNumber = db.ResourseLocation.Where(o => o.ID == id).Select(o => o.name).First().ToString(); // Номер аудитории
            string BuildingName = db.ResourseLocation.Where(o => o.ID == id).Select(o => o.buildings.Name).First().ToString(); //тип аудитории
            string auditorefloor = db.ResourseLocation.Where(o => o.ID == id).Select(o => o.floor).First().ToString(); //тип аудитории

            ViewBag.Location = typeauditore +" " + auditoreNumber + " " + "находится в " + " " +  BuildingName +  " на " + auditorefloor + " этаже";
            ViewBag.Locname = auditoreNumber;
            return View();
        }

        // GET: Resourses
        public ActionResult Index()
        {
            var resourses = db.Resourses.Include(r => r.ResourseLocation).Include(r => r.ResourseTypes).Include(r => r.Status1);
            return View(resourses.ToList());
        }

        public ActionResult SearchAuditore ()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SearchAuditore(string InputNumber, string InputType)
        {

            ViewBag.InputNumber = InputNumber;
            ViewBag.InputType = InputType;
            if (string.IsNullOrEmpty(InputNumber) && string.IsNullOrEmpty(InputType))
            {
                return View();
            }
            if (!string.IsNullOrEmpty(InputNumber) && string.IsNullOrEmpty(InputType))
            {
                return View(db.ResourseLocation.Where(o => o.name.Contains(InputNumber) || o.name == InputNumber));
            }
            if (string.IsNullOrEmpty(InputNumber) && !string.IsNullOrEmpty(InputType))
            {
                return View(db.ResourseLocation.Include(o => o.LocType).Where(o => o.LocType.type.Contains(InputType) || o.LocType.type == InputType));
            }
            if (string.IsNullOrEmpty(InputNumber) && string.IsNullOrEmpty(InputType))
            {
                return View(db.ResourseLocation.Include(o => o.LocType).Where(o => (o.name.Contains(InputNumber) || o.name == InputNumber) && ( o.LocType.type.Contains(InputType) || (o.LocType.type == InputType))));
            }
            return View();
        }
        // GET: Resourses/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Resourses resourses = db.Resourses.Find(id);
            if (resourses == null)
            {
                return HttpNotFound();
            }
            return View(resourses);
        }

        // GET: Resourses/Create
        public ActionResult Create()
        {
            ViewBag.location = new SelectList(db.ResourseLocation, "ID", "name");
            ViewBag.ResourseType = new SelectList(db.ResourseTypes, "ID", "Type_name");
            ViewBag.status = new SelectList(db.Status, "ID", "status1");

            return View();
        }

        // POST: Resourses/Create
        // Чтобы защититься от атак чрезмерной передачи данных, включите определенные свойства, для которых следует установить привязку. Дополнительные 
        // сведения см. в статье https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create( Resourses resourses)
        {
            if (ModelState.IsValid)
            {
                db.Resourses.Add(resourses);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.location = new SelectList(db.ResourseLocation, "ID", "name");
            ViewBag.ResourseType = new SelectList(db.ResourseTypes, "ID", "Type_name", resourses.ResourseType);
            ViewBag.status = new SelectList(db.Status, "ID", "status1", resourses.status);
            return View(resourses);
        }

        // GET: Resourses/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Resourses resourses = db.Resourses.Find(id);
            if (resourses == null)
            {
                return HttpNotFound();
            }
            ViewBag.location = new SelectList(db.ResourseLocation, "ID", "name");
            ViewBag.ResourseType = new SelectList(db.ResourseTypes, "ID", "Type_name", resourses.ResourseType);
            ViewBag.status = new SelectList(db.Status, "ID", "status1", resourses.status);
            return View(resourses);
        }

        // POST: Resourses/Edit/5
        // Чтобы защититься от атак чрезмерной передачи данных, включите определенные свойства, для которых следует установить привязку. Дополнительные 
        // сведения см. в статье https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,Name,Genre,ResourseType,status,location")] Resourses resourses)
        {
            if (ModelState.IsValid)
            {
                db.Entry(resourses).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.location = new SelectList(db.ResourseLocation, "ID", "name");
            ViewBag.ResourseType = new SelectList(db.ResourseTypes, "ID", "Type_name", resourses.ResourseType);
            ViewBag.status = new SelectList(db.Status, "ID", "status1", resourses.status);
            return View(resourses);
        }

        // GET: Resourses/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Resourses resourses = db.Resourses.Find(id);
            if (resourses == null)
            {
                return HttpNotFound();
            }
            return View(resourses);
        }

        // POST: Resourses/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Resourses resourses = db.Resourses.Find(id);
            db.Resourses.Remove(resourses);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
