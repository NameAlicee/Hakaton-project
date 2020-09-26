﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HakatonProject.Models;

namespace HakatonProject.Controllers
{
    public class ResourseLocationsController : Controller
    {
        private Hakaton_projectEntities db = new Hakaton_projectEntities();

        // GET: ResourseLocations
        public ActionResult Index()
        {
            var resourseLocation = db.ResourseLocation.Include(r => r.buildings).Include(r => r.LocType);
            return View(resourseLocation.ToList());
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Search(string InputNumber, string InputType)
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
                return View(db.LocType.Where(o => o.type.Contains(InputType) || o.type == InputType));
            }
            if (string.IsNullOrEmpty(InputNumber) && string.IsNullOrEmpty(InputType))
            {
                return View(db.Resourses.Where(o => (o.Name.Contains(InputNumber) || o.Name == InputNumber) && (o.Genre.Contains(InputType) || o.Genre == InputType)));
            }
            return View();
        }
        // GET: ResourseLocations/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ResourseLocation resourseLocation = db.ResourseLocation.Find(id);
            if (resourseLocation == null)
            {
                return HttpNotFound();
            }
            return View(resourseLocation);
        }

        // GET: ResourseLocations/Create
        public ActionResult Create()
        {
            ViewBag.building = new SelectList(db.buildings, "ID", "Name");
            ViewBag.locationType = new SelectList(db.LocType, "id", "type");
            return View();
        }

        // POST: ResourseLocations/Create
        // Чтобы защититься от атак чрезмерной передачи данных, включите определенные свойства, для которых следует установить привязку. Дополнительные 
        // сведения см. в статье https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,locationType,building,floor,name")] ResourseLocation resourseLocation)
        {
            if (ModelState.IsValid)
            {
                db.ResourseLocation.Add(resourseLocation);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.building = new SelectList(db.buildings, "ID", "Name", resourseLocation.building);
            ViewBag.locationType = new SelectList(db.LocType, "id", "type", resourseLocation.locationType);
            return View(resourseLocation);
        }

        // GET: ResourseLocations/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ResourseLocation resourseLocation = db.ResourseLocation.Find(id);
            if (resourseLocation == null)
            {
                return HttpNotFound();
            }
            ViewBag.building = new SelectList(db.buildings, "ID", "Name", resourseLocation.building);
            ViewBag.locationType = new SelectList(db.LocType, "id", "type", resourseLocation.locationType);
            return View(resourseLocation);
        }

        // POST: ResourseLocations/Edit/5
        // Чтобы защититься от атак чрезмерной передачи данных, включите определенные свойства, для которых следует установить привязку. Дополнительные 
        // сведения см. в статье https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,locationType,building,floor,name")] ResourseLocation resourseLocation)
        {
            if (ModelState.IsValid)
            {
                db.Entry(resourseLocation).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.building = new SelectList(db.buildings, "ID", "Name", resourseLocation.building);
            ViewBag.locationType = new SelectList(db.LocType, "id", "type", resourseLocation.locationType);
            return View(resourseLocation);
        }

        // GET: ResourseLocations/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ResourseLocation resourseLocation = db.ResourseLocation.Find(id);
            if (resourseLocation == null)
            {
                return HttpNotFound();
            }
            return View(resourseLocation);
        }

        // POST: ResourseLocations/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ResourseLocation resourseLocation = db.ResourseLocation.Find(id);
            db.ResourseLocation.Remove(resourseLocation);
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