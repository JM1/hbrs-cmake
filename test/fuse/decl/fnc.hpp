/* Copyright (c) 2016-2018 Jakob Meng, <jakobmeng@web.de>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

#ifndef HBRS_CMAKE_TEST_FUSE_DECL_FNC_HPP
#define HBRS_CMAKE_TEST_FUSE_DECL_FNC_HPP

struct fnc1_t {
	template <typename... Args>
	constexpr decltype(auto)
	operator()(Args&&... args) const;
};

constexpr fnc1_t fnc1{};

struct fnc2_t {
	template <typename... Args>
	constexpr decltype(auto)
	operator()(Args&&... args) const;
};

constexpr fnc2_t fnc2{};

#endif // !HBRS_CMAKE_TEST_FUSE_DECL_FNC_HPP
